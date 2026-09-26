# frozen_string_literal: true

RSpec.describe RecipeScrapers::Parsers::Ingredients do
  def parsed(line) = described_class.call(line).to_h

  it "splits a line into an amount, a unit and an ingredient" do
    expect(parsed("2 cups flour")).to eq(amount: 2.0, unit: "cups", name: "flour")
  end

  it "reads a whole number as a float" do
    expect(parsed("3 eggs")[:amount]).to eq(3.0)
  end

  it "reads a vulgar fraction" do
    expect(parsed("½ teaspoon salt")).to eq(amount: 0.5, unit: "teaspoon", name: "salt")
  end

  it "rounds a slash fraction to two decimals" do
    expect(parsed("1/3 cup sugar")).to eq(amount: 0.33, unit: "cup", name: "sugar")
  end

  it "reads a fraction written with the fraction slash" do
    expect(parsed("1⁄2 cup milk")[:amount]).to eq(0.5)
  end

  it "adds a whole number to the vulgar fraction after a space" do
    expect(parsed("1 ½ cups milk")[:amount]).to eq(1.5)
  end

  it "adds a whole number to the vulgar fraction glued to it" do
    expect(parsed("2¾ cups milk")[:amount]).to eq(2.75)
  end

  it "adds a whole number to the slash fraction after it" do
    expect(parsed("1 1/2 cups milk")[:amount]).to eq(1.5)
  end

  it "reads a decimal written with a comma" do
    expect(parsed("1,5 dl grädde")).to eq(amount: 1.5, unit: "dl", name: "grädde")
  end

  it "reads a decimal written with a point" do
    expect(parsed("2.5 dl hvetemel")).to eq(amount: 2.5, unit: "dl", name: "hvetemel")
  end

  it "takes the lower bound of a range written with a hyphen" do
    expect(parsed("2-3 cloves garlic")).to eq(amount: 2.0, unit: "cloves", name: "garlic")
  end

  it "takes the lower bound of a range written with an en dash" do
    expect(parsed("1/2–1 cup ice cubes")).to eq(amount: 0.5, unit: "cup", name: "ice cubes")
  end

  it "takes the lower bound of a range written with to" do
    expect(parsed("4 to 5 tablespoons icing sugar")).to eq(amount: 4.0, unit: "tablespoons", name: "icing sugar")
  end

  it "reads a unit glued to the amount" do
    expect(parsed("500g Beef Mince")).to eq(amount: 500.0, unit: "g", name: "Beef Mince")
  end

  it "drops the text in parentheses" do
    expect(parsed("1 kg räkor med skal (gärna färska av fin kvalitet)")).
      to eq(amount: 1.0, unit: "kg", name: "räkor med skal")
  end

  it "drops a parenthesis between the amount and the unit" do
    expect(parsed("1 (14 ounce) can tomatoes")).to eq(amount: 1.0, unit: "can", name: "tomatoes")
  end

  it "drops nested parentheses" do
    expect(parsed("4 slices kabocha squash ((or butternut squash) skin-on)")).
      to eq(amount: 4.0, unit: "slices", name: "kabocha squash")
  end

  it "drops a parenthesis inside a word" do
    expect(parsed("2 Gewürzgurke(n)")).to eq(amount: 2.0, unit: nil, name: "Gewürzgurke")
  end

  it "keeps the space before a comma tidy once a parenthesis is gone" do
    expect(parsed("1 onion (large), chopped")).to eq(amount: 1.0, unit: nil, name: "onion, chopped")
  end

  it "leaves the unit empty when the word after the amount is not a unit" do
    expect(parsed("2 large eggs")).to eq(amount: 2.0, unit: nil, name: "large eggs")
  end

  it "leaves the amount and the unit empty when the line has no number" do
    expect(parsed("Salt, to taste")).to eq(amount: nil, unit: nil, name: "Salt, to taste")
  end

  it "keeps the unit as written without its trailing dot" do
    expect(parsed("2 Tbsp. butter")).to eq(amount: 2.0, unit: "Tbsp", name: "butter")
  end

  it "reads a unit of several words" do
    expect(parsed("1,5 çay kaşığı tuz")).to eq(amount: 1.5, unit: "çay kaşığı", name: "tuz")
  end

  it "reads a unit of several abbreviated words" do
    expect(parsed("2 ст. л. сахара")).to eq(amount: 2.0, unit: "ст. л", name: "сахара")
  end

  it "drops the of that joins a unit to the ingredient" do
    expect(parsed("2 cups of cottage cheese")).to eq(amount: 2.0, unit: "cups", name: "cottage cheese")
  end

  it "drops the de that joins a unit to the ingredient" do
    expect(parsed("800 g de tomates")).to eq(amount: 800.0, unit: "g", name: "tomates")
  end

  it "reads an amount and a unit written after the ingredient" do
    expect(parsed("Latte intero 200 ml")).to eq(amount: 200.0, unit: "ml", name: "Latte intero")
  end

  it "reads an amount written after the ingredient without a unit" do
    expect(parsed("Baccello di vaniglia ½")).to eq(amount: 0.5, unit: nil, name: "Baccello di vaniglia")
  end

  it "does not read a percentage as an amount" do
    expect(parsed("Сливки 35%")).to eq(amount: nil, unit: nil, name: "Сливки 35%")
  end

  it "leaves the ingredient empty when nothing but the amount and the unit is left" do
    expect(parsed("2 tbsp (optional)")).to eq(amount: 2.0, unit: "tbsp", name: nil)
  end

  it "drops the comma a removed parenthesis leaves at the end" do
    expect(parsed("2 eggs, (room temperature)")).to eq(amount: 2.0, unit: nil, name: "eggs")
  end

  it "drops the punctuation a removed parenthesis leaves at the start" do
    expect(parsed("1, 9-inch pie crust")).to eq(amount: 1.0, unit: nil, name: "9-inch pie crust")
  end

  it "reads the container of a package and drops its size" do
    expect(parsed("2 12.5 oz cans chunk chicken")).to eq(amount: 2.0, unit: "cans", name: "chunk chicken")
  end

  it "reads the container of a package whose size is hyphenated" do
    expect(parsed("1 15-ounce can black beans")).to eq(amount: 1.0, unit: "can", name: "black beans")
  end

  it "keeps a size that no container follows" do
    expect(parsed("4 6oz. swordfish steaks")).to eq(amount: 4.0, unit: nil, name: "6oz. swordfish steaks")
  end

  it "reads a unit behind a size adjective" do
    expect(parsed("2 large cloves garlic")).to eq(amount: 2.0, unit: "cloves", name: "garlic")
  end

  it "reads a unit behind a qualifier" do
    expect(parsed("4 heaping tablespoons cheese")).to eq(amount: 4.0, unit: "tablespoons", name: "cheese")
  end

  it "keeps a size adjective that no unit follows" do
    expect(parsed("3 large eggs")).to eq(amount: 3.0, unit: nil, name: "large eggs")
  end

  it "reads an amount behind a qualifier" do
    expect(parsed("About 1/2 tsp. kosher salt")).to eq(amount: 0.5, unit: "tsp", name: "kosher salt")
  end

  it "reads an amount behind a label" do
    expect(parsed("Optional: 2 teaspoons Cognac")).to eq(amount: 2.0, unit: "teaspoons", name: "Cognac")
  end

  it "reads an amount written as a word" do
    expect(parsed("Three 6.5-ounce cans chopped clams")).to eq(amount: 3.0, unit: "cans", name: "chopped clams")
  end

  it "reads half written as a word" do
    expect(parsed("meia xícara de água")).to eq(amount: 0.5, unit: "xícara", name: "água")
  end

  it "reads an article in front of a unit as one" do
    expect(parsed("A drizzle of olive oil")).to eq(amount: 1.0, unit: "drizzle", name: "olive oil")
  end

  it "does not read an article in front of an ordinary word as one" do
    expect(parsed("a few sprigs of basil")).to eq(amount: nil, unit: nil, name: "a few sprigs of basil")
  end

  it "reads a pinch with no number as one" do
    expect(parsed("Pinch of salt")).to eq(amount: 1.0, unit: "Pinch", name: "salt")
  end

  it "reads a pinch with no number behind a size adjective as one" do
    expect(parsed("large handful parsley leaves")).to eq(amount: 1.0, unit: "handful", name: "parsley leaves")
  end

  it "reads a pinch with no number after the ingredient as one" do
    expect(parsed("Соль – щепотка")).to eq(amount: 1.0, unit: "щепотка", name: "Соль")
  end

  it "reads an approximate amount after the ingredient" do
    expect(parsed("Vinegar, ~15 g")).to eq(amount: 15.0, unit: "g", name: "Vinegar")
  end

  it "keeps the note after an amount that follows a colon" do
    expect(parsed("Basil: 20 g. fresh")).to eq(amount: 20.0, unit: "g", name: "Basil, fresh")
  end

  it "reads a unit written before the amount after the ingredient" do
    expect(parsed("コンソメ 小さじ1")).to eq(amount: 1.0, unit: "小さじ", name: "コンソメ")
  end

  it "does not read a number inside the ingredient as its amount" do
    expect(parsed("Juice of 1 lime")).to eq(amount: nil, unit: nil, name: "Juice of 1 lime")
  end

  it "adds a whole number to the fraction joined by and" do
    expect(parsed("1 and 1/2 cups cooked broccoli")).to eq(amount: 1.5, unit: "cups", name: "cooked broccoli")
  end

  it "takes the lower bound of a range written with a word for or" do
    expect(parsed("3 o 4 cucharadas de aceite")).to eq(amount: 3.0, unit: "cucharadas", name: "aceite")
  end

  it "sums the amounts joined by a plus in front of one unit" do
    expect(parsed("2/3 + 1/4 cup chocolate chips")).to eq(amount: 0.92, unit: "cup", name: "chocolate chips")
  end

  it "drops a second measure added with a plus" do
    expect(parsed("2/3 cup + 1 tablespoon flour")).to eq(amount: 0.67, unit: "cup", name: "flour")
  end

  it "drops the alternative measure after a slash" do
    expect(parsed("1 ½ cups/190 grams flour")).to eq(amount: 1.5, unit: "cups", name: "flour")
  end

  it "drops the alternative measure after a spaced slash" do
    expect(parsed("200 g / 7 oz linguine")).to eq(amount: 200.0, unit: "g", name: "linguine")
  end

  it "drops the alternative measure written straight after the unit" do
    expect(parsed("3/4 cup 4 oz. pine nuts")).to eq(amount: 0.75, unit: "cup", name: "pine nuts")
  end

  it "drops the article between an amount and the ingredient" do
    expect(parsed("½ a lemon")).to eq(amount: 0.5, unit: nil, name: "lemon")
  end

  it "drops the of and the article between an amount and the ingredient" do
    expect(parsed("1/4 of a red onion")).to eq(amount: 0.25, unit: nil, name: "red onion")
  end

  it "drops the di between an amount and the ingredient" do
    expect(parsed("2 di uova")).to eq(amount: 2.0, unit: nil, name: "uova")
  end

  it "reads the container of a package whose size is a range" do
    expect(parsed("1 10-13 oz Bag Tortilla Chips")).to eq(amount: 1.0, unit: "Bag", name: "Tortilla Chips")
  end

  it "reads a loaf as a unit" do
    expect(parsed("1 1-pound loaf sourdough")).to eq(amount: 1.0, unit: "loaf", name: "sourdough")
  end

  it "reads a zero amount as no amount" do
    expect(parsed("0 ízlés szerint Só")).to eq(amount: nil, unit: nil, name: "ízlés szerint Só")
  end

  it "does not read a unit that opens a hyphenated word" do
    expect(parsed("1 thumb-size piece ginger")).to eq(amount: 1.0, unit: nil, name: "thumb-size piece ginger")
  end

  it "drops the bullet a line opens with" do
    expect(parsed("♥生クリーム 100ml")).to eq(amount: 100.0, unit: "ml", name: "生クリーム")
  end

  it "keeps the ingredient a parenthesis wraps when nothing else is left" do
    expect(parsed("1/2 stick ((4 tbsp) butter)")).to eq(amount: 0.5, unit: "stick", name: "butter")
  end

  it "reads an abbreviated tablespoon written after the ingredient" do
    expect(parsed("Томатная паста - 1 ст. ложка")).to eq(amount: 1.0, unit: "ст. ложка", name: "Томатная паста")
  end

  it "reads an abbreviated teaspoon in its plural" do
    expect(parsed("Соль - 2 ч. ложки")).to eq(amount: 2.0, unit: "ч. ложки", name: "Соль")
  end

  it "reads an abbreviated tablespoon written before the ingredient" do
    expect(parsed("5 ст. ложек сахара")).to eq(amount: 5.0, unit: "ст. ложек", name: "сахара")
  end

  it "moves the preparation written before the amount behind the ingredient" do
    expect(parsed("revet frisk 2 ss pepperrot")).to eq(amount: 2.0, unit: "ss", name: "pepperrot, revet frisk")
  end

  it "does not read a sentence before an amount as a preparation" do
    expect(parsed("Enough water to equal 3/4 cup after orange juice added")).
      to eq(amount: nil, unit: nil, name: "Enough water to equal 3/4 cup after orange juice added")
  end

  it "reads a unit of the recipe language" do
    expect(described_class.call("2 msk smør", language: "nb-NO").unit).to eq("msk")
  end

  it "does not read a unit of another language when the recipe names its own" do
    expect(described_class.call("2 msk smør", language: "en").to_h).to eq(amount: 2.0, unit: nil, name: "msk smør")
  end

  it "reads a metric unit whatever the recipe language" do
    expect(described_class.call("200 г сахара", language: "ru").unit).to eq("г")
    expect(described_class.call("200 ml milk", language: "ru").unit).to eq("ml")
  end

  it "reads the units of every language when the recipe names none" do
    expect(described_class.call("2 msk smør", language: nil).unit).to eq("msk")
  end

  it "reads the units of every language when no vocabulary covers the recipe language" do
    expect(described_class.call("2 msk smør", language: "xx").unit).to eq("msk")
  end

  it "reads a unit a caller adds to the vocabulary" do
    vocabulary = RecipeScrapers::Parsers::Vocabulary.for("en") +
                 RecipeScrapers::Parsers::Vocabulary.new(units: %w[sachet])
    expect(described_class.new(vocabulary).call("1 sachet yeast").to_h).
      to eq(amount: 1.0, unit: "sachet", name: "yeast")
  end
end
