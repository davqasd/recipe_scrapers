# frozen_string_literal: true

RSpec.describe "justonecookbook.com" do
  subject(:recipe) { scrape_cassette("com/justonecookbook", url: "https://www.justonecookbook.com/rice-cracker-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Rice Crackers (Kakimochi)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 Japanese rice cake (kiri mochi)",
      "neutral oil",
      "Diamond Crystal kosher salt (I used Himalayan Pink Salt)",
      "furikake (rice seasoning)",
      "soy sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "Japanese rice cake" },
      { amount: nil, unit: nil, name: "neutral oil" },
      { amount: nil, unit: nil, name: "Diamond Crystal kosher salt" },
      { amount: nil, unit: nil, name: "furikake" },
      { amount: nil, unit: nil, name: "soy sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Before You Start…Please note that this recipe requires 7-10 days of drying time.Gather all the ingredients.",
      "To Dry the Mochi (7–10 Days Before Frying)",
      "Use a knife to cut 4 Japanese rice cakes (mochi) into small pieces about ⅛ inch (3 mm) thick. If your mochi is dried and hard, cut it with the heel of your knife; wedge the knife edge into the mochi and use your non-dominant hand to push the blade down to cut through. Next, lay the mochi pieces in a single layer on a flat tray or wire rack. Here, I use a Japanese bamboo strainer called bonzaru.",
      "Air-dry them with good ventilation for at least one week. As mochi pieces dehydrate, they might break into smaller pieces, so try not to touch them. The mochi pieces will harden and look cracked and flaky on the surface,",
      "Another option: I haven‘t tried this method, but I‘ve read that you can bake the mochi pieces at 400ºF (200ºC) for 15 minutes instead of air-drying them. For a convection oven, reduce the cooking temperature by 25ºF (15ºC). You can lightly brush them with oil and season with salt (so the salt will stick to the mochi pieces).",
      "To Fry the Rice Crackers",
      "In a frying pan (I use a cast iron skillet), add neutral oil to a depth of ¾ inch (2 cm). Turn the heat to medium and heat the oil to 340ºF (170ºC); I recommend an instant-read cooking thermometer to monitor the temperature. When it's hot enough, add just a few mochi pieces at first. If small bubbles start to appear around the mochi, then add more pieces in a single layer, leaving space between them so they can pop and expand. Do not overcrowd the skillet. Tip: If you‘re new to deep-frying, see my post How to Deep-Fry Food at Home for helpful tips.",
      "The mochi pieces will turn white and start to puff up. Turn over each piece and fry until puffed and lightly golden brown. Then, increase the heat so the oil is 350ºF (180ºC) and fry until the mochi pieces are golden brown.",
      "Remove the kakimochi from the oil and place on a wire rack or a plate lined with paper towels. While they are hot, season with Diamond Crystal kosher salt.",
      "Optionally, you can sprinkle them with furikake (rice seasoning) or brush soy sauce on top, reducing the amount of salt if you use soy sauce.",
      "To Serve and Store",
      "Enjoy the Kakimochi immediately. It‘s best to consume them on the same day. Once cooled, you can also put them in an airtight container and store them at room temperature for a few days."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 2],
        ["For the Seasoning Options", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Before You Start…Please note that this recipe requires 7-10 days of drying time.Gather all the ingredients.\nTo Dry the Mochi (7–10 Days Before Frying)\nUse a knife to cut 4 Japanese rice cakes (mochi) into small pieces about ⅛ inch (3 mm) thick. If your mochi is dried and hard, cut it with the heel of your knife; wedge the knife edge into the mochi and use your non-dominant hand to push the blade down to cut through. Next, lay the mochi pieces in a single layer on a flat tray or wire rack. Here, I use a Japanese bamboo strainer called bonzaru.\nAir-dry them with good ventilation for at least one week. As mochi pieces dehydrate, they might break into smaller pieces, so try not to touch them. The mochi pieces will harden and look cracked and flaky on the surface,\nAnother option: I haven‘t tried this method, but I‘ve read that you can bake the mochi pieces at 400ºF (200ºC) for 15 minutes instead of air-drying them. For a convection oven, reduce the cooking temperature by 25ºF (15ºC). You can lightly brush them with oil and season with salt (so the salt will stick to the mochi pieces).\nTo Fry the Rice Crackers\nIn a frying pan (I use a cast iron skillet), add neutral oil to a depth of ¾ inch (2 cm). Turn the heat to medium and heat the oil to 340ºF (170ºC); I recommend an instant-read cooking thermometer to monitor the temperature. When it's hot enough, add just a few mochi pieces at first. If small bubbles start to appear around the mochi, then add more pieces in a single layer, leaving space between them so they can pop and expand. Do not overcrowd the skillet. Tip: If you‘re new to deep-frying, see my post How to Deep-Fry Food at Home for helpful tips.\nThe mochi pieces will turn white and start to puff up. Turn over each piece and fry until puffed and lightly golden brown. Then, increase the heat so the oil is 350ºF (180ºC) and fry until the mochi pieces are golden brown.\nRemove the kakimochi from the oil and place on a wire rack or a plate lined with paper towels. While they are hot, season with Diamond Crystal kosher salt.\nOptionally, you can sprinkle them with furikake (rice seasoning) or brush soy sauce on top, reducing the amount of salt if you use soy sauce.\nTo Serve and Store\nEnjoy the Kakimochi immediately. It‘s best to consume them on the same day. Once cooled, you can also put them in an airtight container and store them at room temperature for a few days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("justonecookbook.com")
    expect(recipe.canonical_url).to eq("https://www.justonecookbook.com/rice-cracker-recipe/")
    expect(recipe.site_name).to eq("Just One Cookbook")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Namiko Hirasawa Chen")
    expect(recipe.description).to eq("Let’s make fresh Kakimochi at home with this Japanese Rice Cracker recipe. Flavored with salt, soy sauce, or furikake seasoning, this crunchy and savory snack really hits the spot. Perfect to enjoy with a cup of hot green tea.")
    expect(recipe.image).to eq("https://www.justonecookbook.com/wp-content/uploads/2016/03/Kakimochi.jpg")
    expect(recipe.category).to eq("Snack")
    expect(recipe.cuisine).to eq("Japanese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[mochi okaki])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(15)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "56 kcal",
      "carbohydrateContent" => "13 g",
      "proteinContent" => "1 g",
      "sodiumContent" => "40 mg",
      "sugarContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 56.0 },
      { name: "carbohydrateContent", unit: "g", amount: 13.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 40.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
