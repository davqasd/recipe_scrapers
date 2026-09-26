# frozen_string_literal: true

RSpec.describe "cafedelites.com" do
  subject(:recipe) { scrape_cassette("com/cafedelites", url: "https://cafedelites.com/best-churros-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Churros Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup sugar",
      "1/2 teaspoon ground cinnamon",
      "4 ounces butter",
      "1 cup water",
      "2 tablespoons white granulated sugar",
      "1 teaspoon pure vanilla extract",
      "3/4 teaspoon ground cinnamon",
      "1/2 teaspoon salt",
      "1 1/4 cups all-purpose (or plain flour)",
      "2 eggs (at room temperature)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "sugar" },
      { amount: 0.5, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 4.0, unit: "ounces", name: "butter" },
      { amount: 1.0, unit: "cup", name: "water" },
      { amount: 2.0, unit: "tablespoons", name: "white granulated sugar" },
      { amount: 1.0, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 0.75, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.25, unit: "cups", name: "all-purpose" },
      { amount: 2.0, unit: nil, name: "eggs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREPARE YOUR WORK STATION",
      "Combine 1/2 cup sugar and 1/2 teaspoon cinnamon together in a shallow bowl for your cinnamon sugar coating.",
      "Line a large plate with a double layer of paper towel ready for your cooked churros.",
      "Fill a large pot or deep skillet with 1 1/2 - 2 cups of oil.",
      "MAKE THE BEST CHURRO DOUGH",
      "Heat the butter in a medium-sized saucepan. Add in the water, sugar, vanilla, cinnamon and salt. Bring to a simmer for 5 minutes while mixing occasionally. Add in the flour, stirring with a large wooden spoon until well blended and forms a ball.",
      "Take off heat and allow to cool for 10 minutes, or until just warm to the touch.",
      "While dough is cooling, heat oil over medium-high heat to 360°F (180°C).",
      "Once dough has cooled, add one egg, quickly beating until completely incorporated (it will look like it's not coming together, but keep beating)! Add in the second egg and repeat the process until a dough forms.",
      "Scoop dough into a strong double lined pastry bag with a large open star tip nozzle. (I suggest using Wilton 1M or Ateco 845/846.)",
      "COOK CHURROS",
      "Lightly oil the blade end of your scissors and set aside. Carefully pipe 5-6-inch long strips of dough into hot oil, cutting the ends with oiled scissors. Fry 4-5 churros at a time to avoid over-crowding your pot.",
      "Fry until golden browned, about 2 minutes each side. Transfer to paper towel lined plate for a few seconds, then roll in the cinnamon sugar.",
      "Repeat with remaining dough.",
      "Serve warm with melted chocolate or caramel sauce, fruit or ice cream."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["COATING", 2],
        ["CHURROS", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREPARE YOUR WORK STATION\nCombine 1/2 cup sugar and 1/2 teaspoon cinnamon together in a shallow bowl for your cinnamon sugar coating.\nLine a large plate with a double layer of paper towel ready for your cooked churros.\nFill a large pot or deep skillet with 1 1/2 - 2 cups of oil.\nMAKE THE BEST CHURRO DOUGH\nHeat the butter in a medium-sized saucepan. Add in the water, sugar, vanilla, cinnamon and salt. Bring to a simmer for 5 minutes while mixing occasionally. Add in the flour, stirring with a large wooden spoon until well blended and forms a ball.\nTake off heat and allow to cool for 10 minutes, or until just warm to the touch.\nWhile dough is cooling, heat oil over medium-high heat to 360°F (180°C).\nOnce dough has cooled, add one egg, quickly beating until completely incorporated (it will look like it's not coming together, but keep beating)! Add in the second egg and repeat the process until a dough forms.\nScoop dough into a strong double lined pastry bag with a large open star tip nozzle. (I suggest using Wilton 1M or Ateco 845/846.)\nCOOK CHURROS\nLightly oil the blade end of your scissors and set aside. Carefully pipe 5-6-inch long strips of dough into hot oil, cutting the ends with oiled scissors. Fry 4-5 churros at a time to avoid over-crowding your pot.\nFry until golden browned, about 2 minutes each side. Transfer to paper towel lined plate for a few seconds, then roll in the cinnamon sugar.\nRepeat with remaining dough.\nServe warm with melted chocolate or caramel sauce, fruit or ice cream.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cafedelites.com")
    expect(recipe.canonical_url).to eq("https://cafedelites.com/best-churros-recipe/")
    expect(recipe.site_name).to eq("Cafe Delites")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karina Carrel")
    expect(recipe.description).to eq("Crispy on the outside, buttery soft on the inside, exactly how Churros should be! If you are craving the best churros, then this churros recipe is just what you’ve been waiting for!")
    expect(recipe.image).to eq("https://cafedelites.com/wp-content/uploads/2020/05/Churros-IMAGE-121.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Spanish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["churros", "churros recipe", "dessert", "Spanish dessert", "Sweet"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "100 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "1 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "3 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "29 mg",
      "sodiumContent" => "102 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "1.3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 100.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 29.0 },
      { name: "sodiumContent", unit: "mg", amount: 102.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.3 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
