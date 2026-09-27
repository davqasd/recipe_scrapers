# frozen_string_literal: true

RSpec.describe "womensweeklyfood.com.au" do
  subject(:recipe) { scrape_cassette("au/womensweeklyfood", url: "https://www.womensweeklyfood.com.au/recipe/dessert/biscoff-cheesecake-white-choc/") }

  it "reads the title" do
    expect(recipe.title).to eq("Double Biscoff cheesecake with white chocolate")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "350g Lotus Biscoff biscuits",
      "400g jar crunchy Biscoff spread",
      "½ cup (125ml) thickened cream",
      "180g white chocolate, chopped finely",
      "750g cream cheese, softened",
      "1 cup (220g) caster sugar",
      "1½ teaspoons vanilla bean paste",
      "3 eggs",
      "2 tablespoons lemon juice",
      "1 cup (250ml) thickened cream, extra, whipped to firm peaks"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 350.0, unit: "g", name: "Lotus Biscoff biscuits" },
      { amount: 400.0, unit: "g", name: "jar crunchy Biscoff spread" },
      { amount: 0.5, unit: "cup", name: "thickened cream" },
      { amount: 180.0, unit: "g", name: "white chocolate, chopped finely" },
      { amount: 750.0, unit: "g", name: "cream cheese, softened" },
      { amount: 1.0, unit: "cup", name: "caster sugar" },
      { amount: 1.5, unit: "teaspoons", name: "vanilla bean paste" },
      { amount: 3.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: "tablespoons", name: "lemon juice" },
      { amount: 1.0, unit: "cup", name: "thickened cream, extra, whipped to firm peaks" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1.",
      "Preheat the oven to 150°C (130°C fan-forced). Grease a 23cm springform pan.",
      "2.",
      "Process biscuits until fine, reserve 1 tablespoon of the biscuit crumb for decorating. Add Biscoff spread and pulse to combine (the texture should be similar to wet sand).",
      "3.",
      "Press the mixture firmly over the base and side of prepared pan. Place on an oven tray and refrigerate while preparing the filling.",
      "4.",
      "Combine cream and white chocolate in a small saucepan; stir over low heat until smooth. Cool.",
      "5.",
      "Beat cream cheese, sugar and vanilla in a large bowl with an electric mixer until smooth. Beat in eggs, one at a time, then lemon juice. Beat in white chocolate mixture.",
      "6.",
      "Pour filling into the pan; bake for 1 hour or until just set. Cool cheesecake in the oven with the door ajar.",
      "7.",
      "Refrigerate cheesecake for at least 2 hours before cutting.",
      "8.",
      "To decorate, place whipped cream into a piping bag fitted with a 1cm plain tube. Pipe ‘kisses’ over the top of the cheesecake, sprinkle with reserved biscuit crumb. Cheesecake suitable to freeze before decorating."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1.\nPreheat the oven to 150°C (130°C fan-forced). Grease a 23cm springform pan.\n2.\nProcess biscuits until fine, reserve 1 tablespoon of the biscuit crumb for decorating. Add Biscoff spread and pulse to combine (the texture should be similar to wet sand).\n3.\nPress the mixture firmly over the base and side of prepared pan. Place on an oven tray and refrigerate while preparing the filling.\n4.\nCombine cream and white chocolate in a small saucepan; stir over low heat until smooth. Cool.\n5.\nBeat cream cheese, sugar and vanilla in a large bowl with an electric mixer until smooth. Beat in eggs, one at a time, then lemon juice. Beat in white chocolate mixture.\n6.\nPour filling into the pan; bake for 1 hour or until just set. Cool cheesecake in the oven with the door ajar.\n7.\nRefrigerate cheesecake for at least 2 hours before cutting.\n8.\nTo decorate, place whipped cream into a piping bag fitted with a 1cm plain tube. Pipe ‘kisses’ over the top of the cheesecake, sprinkle with reserved biscuit crumb. Cheesecake suitable to freeze before decorating.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("womensweeklyfood.com.au")
    expect(recipe.canonical_url).to eq("https://www.womensweeklyfood.com.au/recipe/dessert/biscoff-cheesecake-white-choc/")
    expect(recipe.site_name).to eq("Women's Weekly Food")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("Chanel Gellin")
    expect(recipe.description).to eq("An irresistible finish to a dinner party or special birthday.")
    expect(recipe.image).to eq("https://api.photon.aremedia.net.au/wp-content/uploads/sites/4/2023/12/Wordpress_BiscoffWhiteChocCheesecake.jpg?fit=1080%2C1080&format=auto")
    expect(recipe.category).to eq("dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to eq("Bake")
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(%w[Biscuit cheesecake christmas])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#primary")
  end
end
