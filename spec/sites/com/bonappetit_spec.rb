# frozen_string_literal: true

RSpec.describe "bonappetit.com" do
  subject(:recipe) { scrape_cassette("com/bonappetit", url: "https://www.bonappetit.com/recipe/pork-chops-with-celery-and-almond-salad") }

  it "reads the title" do
    expect(recipe.title).to eq("Pork Chops with Celery Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup dried unsweetened cranberries",
      "3 tablespoons unseasoned rice vinegar",
      "2 1½-inch-thick bone-in pork rib chops (about 1 pound each), patted dry",
      "Kosher salt",
      "4 tablespoons extra-virgin olive oil, divided",
      "3 sprigs thyme",
      "3 garlic cloves, smashed",
      "3 tablespoons unsalted butter, cut into pieces",
      "1 small shallot, finely chopped",
      "6 large or 8 medium celery stalks, thinly sliced on a diagonal",
      "½ cup parsley leaves with tender stems",
      "¼ cup chopped salted, dry-roasted almonds",
      "1 ounce Parmesan, shaved"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "dried unsweetened cranberries" },
      { amount: 3.0, unit: "tablespoons", name: "unseasoned rice vinegar" },
      { amount: 2.0, unit: nil, name: "1½-inch-thick bone-in pork rib chops, patted dry" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: 4.0, unit: "tablespoons", name: "extra-virgin olive oil, divided" },
      { amount: 3.0, unit: "sprigs", name: "thyme" },
      { amount: 3.0, unit: nil, name: "garlic cloves, smashed" },
      { amount: 3.0, unit: "tablespoons", name: "unsalted butter, cut into pieces" },
      { amount: 1.0, unit: nil, name: "small shallot, finely chopped" },
      { amount: 6.0, unit: nil, name: "large or 8 medium celery stalks, thinly sliced on a diagonal" },
      { amount: 0.5, unit: "cup", name: "parsley leaves with tender stems" },
      { amount: 0.25, unit: "cup", name: "chopped salted, dry-roasted almonds" },
      { amount: 1.0, unit: "ounce", name: "Parmesan, shaved" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine cranberries and vinegar in a small bowl and set aside.",
      "Season pork generously with salt, then rub with 1 Tbsp. oil total. Heat a dry medium skillet, preferably cast iron, over medium. Cook pork chops, moving once or twice to hotter areas of skillet, until first side is deeply browned, 6–9 minutes. Turn pork chops and cook until second sides are browned, about 5 minutes. Working one at a time, set chops on fatty side with tongs to melt and brown fat cap, about 1 minute each. At this point an instant-read thermometer inserted into the center of each chop should register 135°.",
      "Add thyme, garlic, and butter to skillet and swirl to melt butter. Tilt skillet toward you so butter pools in the pan and spoon foaming butter over chops continuously until butter is browned, about 1 minute. Transfer pork chops, thyme, and garlic to a cutting board and let meat rest while you assemble the salad.",
      "Combine shallot and a couple of pinches of salt in a large bowl. Pour vinegar from reserved cranberries into bowl. Whisking constantly, gradually add remaining 3 Tbsp. oil. Add cranberries, celery, parsley, almonds, Parmesan, and several pinches of salt; toss to combine.",
      "Cut along bones to remove meat from pork chops; slice meat ½\" thick. Transfer meat and bones to a platter along with garlic and thyme, then drizzle any accumulated juices left on cutting board over top. Serve with salad."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine cranberries and vinegar in a small bowl and set aside.\nSeason pork generously with salt, then rub with 1 Tbsp. oil total. Heat a dry medium skillet, preferably cast iron, over medium. Cook pork chops, moving once or twice to hotter areas of skillet, until first side is deeply browned, 6–9 minutes. Turn pork chops and cook until second sides are browned, about 5 minutes. Working one at a time, set chops on fatty side with tongs to melt and brown fat cap, about 1 minute each. At this point an instant-read thermometer inserted into the center of each chop should register 135°.\nAdd thyme, garlic, and butter to skillet and swirl to melt butter. Tilt skillet toward you so butter pools in the pan and spoon foaming butter over chops continuously until butter is browned, about 1 minute. Transfer pork chops, thyme, and garlic to a cutting board and let meat rest while you assemble the salad.\nCombine shallot and a couple of pinches of salt in a large bowl. Pour vinegar from reserved cranberries into bowl. Whisking constantly, gradually add remaining 3 Tbsp. oil. Add cranberries, celery, parsley, almonds, Parmesan, and several pinches of salt; toss to combine.\nCut along bones to remove meat from pork chops; slice meat ½\" thick. Transfer meat and bones to a platter along with garlic and thyme, then drizzle any accumulated juices left on cutting board over top. Serve with salad.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bonappetit.com")
    expect(recipe.canonical_url).to eq("https://www.bonappetit.com/recipe/pork-chops-with-celery-and-almond-salad")
    expect(recipe.site_name).to eq("Bon Appétit")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Adam Rapoport")
    expect(recipe.description).to eq("Rich butter-basted pork offset by a bright, crunchy salad comes together quick and easy.")
    expect(recipe.image).to eq("https://assets.bonappetit.com/photos/59e4d7dc3279981dd6c79847/16:9/w_3519,h_1979,c_limit/pork-chops-with-celery-and-almond-salad.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "celery",
      "almond",
      "pork chop",
      "main",
      "sear",
      "dinner",
      "do not show on encore",
      "web"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.8)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
