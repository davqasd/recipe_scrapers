# frozen_string_literal: true

RSpec.describe "mccormick.com" do
  subject(:recipe) { scrape_cassette("com/mccormick", url: "https://www.mccormick.com/blogs/recipes/chocolate-frog-finishing-sugar-cookie-dough-bites") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Frog Finishing Sugar Cookie Dough Bites")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 package (4 ounces) cream cheese, softened",
      "1/3 cup salted butter, softened",
      "2/3 cup confectioners' sugar",
      "1/2 cup McCormick® Harry Potter Chocolate Frog Finishing Sugar, divided",
      "2 teaspoons McCormick® Harry Potter Vanilla Extract",
      "1/4 teaspoon salt",
      "1 to 1 1/4 cups finely crushed vanilla wafer crumbs (about 30 to 35 vanilla wafers)",
      "1/3 cup miniature chocolate chips"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "package", name: "cream cheese, softened" },
      { amount: 0.33, unit: "cup", name: "salted butter, softened" },
      { amount: 0.67, unit: "cup", name: "confectioners' sugar" },
      { amount: 0.5, unit: "cup", name: "McCormick® Harry Potter Chocolate Frog Finishing Sugar, divided" },
      { amount: 2.0, unit: "teaspoons", name: "McCormick® Harry Potter Vanilla Extract" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "cups", name: "finely crushed vanilla wafer crumbs" },
      { amount: 0.33, unit: "cup", name: "miniature chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Beat cream cheese and butter in large bowl with an electric mixer on medium speed until light and fluffy. Add confectioners’ sugar, 1/4 cup of the Finishing Sugar, vanilla and salt. Beat until smooth. Stir in vanilla wafer crumbs and chocolate chips. Cover and place in freezer 30 minutes.",
      "Scoop cookie dough by the heaping tablespoonful and shape into balls. Place on wax paper-lined sheet pan. Return to freezer for at least 30 minutes.",
      "Roll bites in remaining Finishing Sugar. Store cookie dough bites between layers of wax paper in airtight container in freezer until ready to serve. Store frozen up to 2 weeks."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Beat cream cheese and butter in large bowl with an electric mixer on medium speed until light and fluffy. Add confectioners’ sugar, 1/4 cup of the Finishing Sugar, vanilla and salt. Beat until smooth. Stir in vanilla wafer crumbs and chocolate chips. Cover and place in freezer 30 minutes.\nScoop cookie dough by the heaping tablespoonful and shape into balls. Place on wax paper-lined sheet pan. Return to freezer for at least 30 minutes.\nRoll bites in remaining Finishing Sugar. Store cookie dough bites between layers of wax paper in airtight container in freezer until ready to serve. Store frozen up to 2 weeks.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mccormick.com")
    expect(recipe.canonical_url).to eq("https://www.mccormick.com/blogs/recipes/chocolate-frog-finishing-sugar-cookie-dough-bites")
    expect(recipe.site_name).to eq("McCormick")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("McCormick & Company")
    expect(recipe.description).to eq("Crushed vanilla wafers, chocolate chips, plus the satisfying crunch and rich toffee flavor of our Chocolate Frog™ Finishing Sugar add a whimsical sweetness to these 15-minute, no-bake treats—the perfect pick-me-ups for a wizarding study session.")
    expect(recipe.image).to eq("https://mccormick.widen.net/content/0zgylvixps/jpeg/McCormick_Harry_Potter_chocolate_frog_cookie_dough_bites_2026_1620x1020.jpg?crop=true&anchor=0,0&q=80&color=ffffffff&u=l1ttiu&w=1620&h=1020")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("25 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["American", "Chocolatey", "Dairy", "Desserts", "Entertaining", "No Bake or Cook", "Snack"])
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
    expect(recipe.links).to include("/")
  end
end
