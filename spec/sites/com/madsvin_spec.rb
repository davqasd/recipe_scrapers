# frozen_string_literal: true

RSpec.describe "madsvin.com" do
  subject(:recipe) { scrape_cassette("com/madsvin", url: "https://madsvin.com/pandekager/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pandekager")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "125 gram hvedemel",
      "3 æg (mellemstore)",
      "3 dl mælk (jeg brugte sødmælk - anden mælk kan også fint bruges)",
      "2 spsk sukker (både rørsukker og hvid sukker kan bruges)",
      "½ stang vanilje (eller 1 spsk vaniljesukker)",
      "25 gram smør (smeltet)",
      "½ tsk salt",
      "smør (til stegning - neutral olie kan også bruges)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 125.0, unit: "gram", name: "hvedemel" },
      { amount: 3.0, unit: nil, name: "æg" },
      { amount: 3.0, unit: "dl", name: "mælk" },
      { amount: 2.0, unit: "spsk", name: "sukker" },
      { amount: 0.5, unit: "stang", name: "vanilje" },
      { amount: 25.0, unit: "gram", name: "smør" },
      { amount: 0.5, unit: "tsk", name: "salt" },
      { amount: nil, unit: nil, name: "smør" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pandekager",
      "Hæld mel, salt, sukker og vanilje i en skål og slå æggene ud i den. Pisk sammen til en ensformet masse uden klumper.",
      "Smelt smør i en kasserolle eller i mikroovnen, og rør ud i pandekagedejen.",
      "Pisk til sidst mælk i i dejmassen, og sæt den på køl i 20-30 minutter, så den lige kan nå at sætte sig (det hjælper også pandekagen til at holde lidt bedre sammen).",
      "Put en klat smør på en middelvarm pande, hæld 0,5-0,75 dl pandekagedej på panden og lad det stege til pandekagen bliver fast - det tager 45-60 sekunder.. Vend den herefter og lad den stege i 45-60 sekunders tid, så den er let gylden på begge sider. Læg pandekagen på en tallerken og dæk med staniol/alufolie så de holdes varme.",
      "Gentag ovenstående trin til alle pandekager er lavet.",
      "Servér med marmelade, sukker, is, sirup, honning, frugt - eller hvad du nu har lyst til. Her er det vitterligt kun fantasien, der sætter grænser."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Pandekager", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pandekager\nHæld mel, salt, sukker og vanilje i en skål og slå æggene ud i den. Pisk sammen til en ensformet masse uden klumper.\nSmelt smør i en kasserolle eller i mikroovnen, og rør ud i pandekagedejen.\nPisk til sidst mælk i i dejmassen, og sæt den på køl i 20-30 minutter, så den lige kan nå at sætte sig (det hjælper også pandekagen til at holde lidt bedre sammen).\nPut en klat smør på en middelvarm pande, hæld 0,5-0,75 dl pandekagedej på panden og lad det stege til pandekagen bliver fast - det tager 45-60 sekunder.. Vend den herefter og lad den stege i 45-60 sekunders tid, så den er let gylden på begge sider. Læg pandekagen på en tallerken og dæk med staniol/alufolie så de holdes varme.\nGentag ovenstående trin til alle pandekager er lavet.\nServér med marmelade, sukker, is, sirup, honning, frugt - eller hvad du nu har lyst til. Her er det vitterligt kun fantasien, der sætter grænser.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("madsvin.com")
    expect(recipe.canonical_url).to eq("https://madsvin.com/pandekager/")
    expect(recipe.site_name).to eq("Madsvin.com")
    expect(recipe.language).to eq("da-DK")
    expect(recipe.author).to eq("Mads Vindfeld Andersen")
    expect(recipe.description).to eq("De lækreste hjemmelavede pandekager, der vækker glæde hos både børn og voksne")
    expect(recipe.image).to eq("https://madsvin.com/wp-content/uploads/2020/08/Pandekager-opskrift.jpg")
    expect(recipe.category).to eq("bagværk")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["pandekage", "pandekage opskrift", "Pandekager"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(26)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
