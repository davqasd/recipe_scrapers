# frozen_string_literal: true

RSpec.describe "andy-cooks.com" do
  subject(:recipe) { scrape_cassette("com/andy_cooks", url: "https://www.andy-cooks.com/blogs/recipes/rissoles-with-curry-sauce-1") }

  it "reads the title" do
    expect(recipe.title).to eq("Rissoles with Curry Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 carrot",
      "1 zucchini",
      "sea salt and black pepper, to season",
      "120g dried breadcrumbs",
      "60ml (¼ cup) milk",
      "500g beef mince",
      "1 brown onion",
      "20ml (1 tbsp) Worcestershire sauce",
      "1 tsp Maggi seasoning",
      "peanut oil (or other neutral flavoured oil), for frying",
      "mashed potato and steamed broccolini, to serve",
      "40g butter",
      "1 brown onion",
      "1 thumb-size piece fresh ginger",
      "3 cloves garlic",
      "20g plain flour",
      "2 tsp tomato paste (tomato puree)",
      "1½ tbsp curry powder",
      "250ml (1 cup) chicken stock",
      "1 tsp honey"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "carrot" },
      { amount: 1.0, unit: nil, name: "zucchini" },
      { amount: nil, unit: nil, name: "sea salt and black pepper, to season" },
      { amount: 120.0, unit: "g", name: "dried breadcrumbs" },
      { amount: 60.0, unit: "ml", name: "milk" },
      { amount: 500.0, unit: "g", name: "beef mince" },
      { amount: 1.0, unit: nil, name: "brown onion" },
      { amount: 20.0, unit: "ml", name: "Worcestershire sauce" },
      { amount: 1.0, unit: "tsp", name: "Maggi seasoning" },
      { amount: nil, unit: nil, name: "peanut oil, for frying" },
      { amount: nil, unit: nil, name: "mashed potato and steamed broccolini, to serve" },
      { amount: 40.0, unit: "g", name: "butter" },
      { amount: 1.0, unit: nil, name: "brown onion" },
      { amount: 1.0, unit: nil, name: "thumb-size piece fresh ginger" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 20.0, unit: "g", name: "plain flour" },
      { amount: 2.0, unit: "tsp", name: "tomato paste" },
      { amount: 1.5, unit: "tbsp", name: "curry powder" },
      { amount: 250.0, unit: "ml", name: "chicken stock" },
      { amount: 1.0, unit: "tsp", name: "honey" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Grate the carrot and zucchini and combine in another large bowl. Season with salt and mix well, then set aside for 20 minutes.",
      "Combine the breadcrumbs and milk in a large bowl and mix well. Set aside to soak for 10 minutes.",
      "Grate the onion and add to the breadcrumbs mixture, along with the beef mince, Worcestershire sauce, Maggi seasoning, and season with salt and pepper.",
      "Squeeze all the excess liquid from the carrot and zucchini mixture, then add to the meat mixture. Mix well, then portion into 60g patties, place on a large tray and gently flatten.",
      "Finely dice the onion (or you could grate it) and finely grate the ginger and garlic.",
      "Melt the butter in a small saucepan over medium heat. Add the onions, season with some salt and cook for 2-3 minutes, stirring, until softened.",
      "Add the ginger and garlic and stir through, then sprinkle over the flour. Cook for 1-2 minutes to cook the flour out, stirring constantly.",
      "Add the tomato paste and mix through well, then add the curry powder and cook for 1 minute to toast the powder.",
      "Gradually whisk in chicken stock until smooth and bring to a simmer. Stir in the honey and season to taste. Reduce the heat to low and let simmer while you cook the rissoles.",
      "Heat enough peanut oil in a large frying pan to cover the base of the pan, over medium-high heat.",
      "Cook the rissoles, in batches, for 9-10 minutes, turning when browned well on each side. Transfer to a tray and repeat with the next batch.",
      "Serve the rissoles on a bed of mashed potato, with some steamed broccolini on the side. Spoon over the curry sauce and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Grate the carrot and zucchini and combine in another large bowl. Season with salt and mix well, then set aside for 20 minutes.\nCombine the breadcrumbs and milk in a large bowl and mix well. Set aside to soak for 10 minutes.\nGrate the onion and add to the breadcrumbs mixture, along with the beef mince, Worcestershire sauce, Maggi seasoning, and season with salt and pepper.\nSqueeze all the excess liquid from the carrot and zucchini mixture, then add to the meat mixture. Mix well, then portion into 60g patties, place on a large tray and gently flatten.\nFinely dice the onion (or you could grate it) and finely grate the ginger and garlic.\nMelt the butter in a small saucepan over medium heat. Add the onions, season with some salt and cook for 2-3 minutes, stirring, until softened.\nAdd the ginger and garlic and stir through, then sprinkle over the flour. Cook for 1-2 minutes to cook the flour out, stirring constantly.\nAdd the tomato paste and mix through well, then add the curry powder and cook for 1 minute to toast the powder.\nGradually whisk in chicken stock until smooth and bring to a simmer. Stir in the honey and season to taste. Reduce the heat to low and let simmer while you cook the rissoles.\nHeat enough peanut oil in a large frying pan to cover the base of the pan, over medium-high heat.\nCook the rissoles, in batches, for 9-10 minutes, turning when browned well on each side. Transfer to a tray and repeat with the next batch.\nServe the rissoles on a bed of mashed potato, with some steamed broccolini on the side. Spoon over the curry sauce and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("andy-cooks.com")
    expect(recipe.canonical_url).to eq("https://www.andy-cooks.com/blogs/recipes/rissoles-with-curry-sauce-1")
    expect(recipe.site_name).to eq("Andy Cooks")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Andy")
    expect(recipe.description).to eq("This was a staple dinner option for Katelyn when she was growing up. Juicy, plump beef rissoles served with a rich curry sauce, with some mashed potatoes and green beans on the side. You don’t need to make it with beef, you can swap the protein for chicken, lamb or turkey. I think these rissoles have plenty of flavour but the curry sauce just takes it to another level. If the kids don’t like the curry sauce, you can always add the classic tomato sauce on the side (I won’t be offended). The prep and cooking time will only take you 40 minutes and you can steam some veggies, prep a salad, or make some mashed potatoes at the same time.Ingredient NotesMince - I like to use 80/20 beef mince, so 80 meat 20% fat to ensure it’s nice and juicy once cooked. You can go for a leaner mince but it may not be as juicy. You can also use chicken, pork, lamb or turkey mince. Breadcrumbs - You want to buy fine, dried breadcrumbs for this recipe as they will hydrate well in the milk and bind properly to the mince. Peanut oil - for this recipe, I like to use a neutral flavoured oil so you get the full flavour of the beef in the rissoles. Neutral flavoured oils include peanut, canola or vegetable oil. If you would prefer olive oil, that’s fine - it will still taste good. Maggi seasoning - this is to boost the depth of flavour and add extra salty and umami flavours. It is quite strong so you don’t need too much. If you don’t have it, you can swap out for light soy sauce instead, it won’t be the same but it will be close. Carrot & Zucchini - Make sure you squeeze out as much liquid as possible before adding to the rissole mixture. You’ll get enough moisture from the mince, and any extra may cause the rissoles to break or start to steam in the pan so you’ll lose the colour and crust. Tools﻿Here’s some key equipment you’ll need for this cook.Standing grater - For the carrots, zucchini and onion. Mixing bowls - You’ll need two large (for the grated veg and one for the rissole mixture) and one small mixing (for the breadcrumb mixture) bowl. Trays - One to line your rissoles on before cooking and then another with a rack for one they’re cooked. Small/medium saucepan - I use a small/medium stainless steel saucepan or saucier (around 20cm/ 7.8 inches), to cook the curry sauce in. Large casserole dish - This is to cook your rissoles in. I’ve used a enamelled cast iron casserole dish but you can also use a large cast iron or carbon steel frying pan. Chefs knife, chopping board, tongs, wooden spoon and whisk")
    expect(recipe.image).to eq("https://cdn.shopify.com/s/files/1/0725/3911/1726/files/20260219042530-andy-20cooks-20-20easy-20dinner-20rissoles-20with-20mash-20and-20greens.jpg?v=1771475132&width=1600&height=900")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Australian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(%w[Dinner Protein Beef Easy])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "4" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#MainContent")
  end
end
