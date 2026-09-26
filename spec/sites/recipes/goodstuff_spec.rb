# frozen_string_literal: true

RSpec.describe "goodstuff.recipes" do
  subject(:recipe) { scrape_cassette("recipes/goodstuff", url: "https://goodstuff.recipes/small-batch-lemon-marmalade/") }

  it "reads the title" do
    expect(recipe.title).to eq("Small-batch Lemon Marmalade")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/4 lbs Meyer lemons",
      "3 cups water",
      "3 cups granulated sugar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "lbs", name: "Meyer lemons" },
      { amount: 3.0, unit: "cups", name: "water" },
      { amount: 3.0, unit: "cups", name: "granulated sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREPARE THE JARS",
      "This recipe will make at least 3 8-oz jars, and often a bit more.Gather 3 8-oz jelly jars, and 2 4-oz jars as well. Make sure your jars are sparkling clean. Wash the lids in warm water and set aside. Keep the bands handy. Have an extra small jar, or custard cup, clean and ready for any excess jam.",
      "PREPARE THE LEMONS",
      "Wash the lemons, discarding any that are moldy or damaged.]",
      "Cut both ends off each lemon. Working one at a time, stand the lemon on end, and cut in half lengthwise. Cut each lemon half into 3 segments, also lengthwise. As you cut these lemon segments, pull off any exposed membranes, if you can, and set them aside. Cut away the pithy core, and remove all seeds. Set aside all the pith and seeds and membranes in a little pile; you'll need them later. Cut each lemon segment crosswise into small pieces, making little truncated triangles of lemon peel and pulp. By the time you've cut all the lemons, you should have 3 cups of little lemon pieces.",
      "Put all the seeds, membranes, and pith into a tea filter bag, or a bag you've made out of two layers of cheesecloth. Tie the bag shut so none of the seeds can get out. This is your pectin bag.",
      "COOK LEMONS & WATER",
      "Put 3 cups of water into a large, wide pot (I use this 4-qt one) Put the pectin bag into the pot also.",
      "Over high heat, bring this mixture to a strong boil. Let it boil, uncovered, for 20-25 minutes, until the peels are soft and cooked through. If too much of the water evaporates, and peels start sticking to the bottom of the pan, add a little more water back to the pot. Test one of the lemon peel pieces by eating it: it should be very soft. If it's still chewy, keep cooking. When the peels are soft, remove the pot from the heat. Remove the pectin bag, and put it in a separate bowl. Let it cool until it's comfortable to touch.",
      "ADD PECTIN & SUGAR",
      "Once the pectin bag has cooled enough that you can handle it, squeeze it to extract any extra pectin. I like to wear gloves for this part; it's messy. Squeeze the bag thoroughly; you could get about a teaspoon of thickish pectin. Return this to the pot with the lemons and water, and discard the rest of the bag.",
      "Add 3 cups of sugar to the water/lemon mixture.",
      "FINAL COOK: MAKE IT JAM",
      "Put a small saucer or two in the freezer - you'll use these to test the set of the jam. Put your dry jelly jars, without lids, in a 200˚ oven. This will not only sterilize the jars, but it helps to keep them from cracking due to temperature differential when you add the hot marmalade to them. Put the lids in a glass or ceramic bowl, and pour some boiling water over them. Let this stand as you prepare the jam. Heat a large pot of water -- this will be the pot where you seal the jars. The water must reach more than 1.5 inches over the tops of the jars. The water doesn't need to boil at this point, but it does need to be quite warm.",
      "Place the marmalade mixture over medium high heat, and bring it to a rapid boil, stirring occasionally. Make sure nothing sticks to the bottom of the pan. When it first comes to a boil, it will foam up a lot (which is why you need a big pot.) Stir if need be to bring the foam back down. Lower the heat if the mixture threatens to overflow the pot.",
      "You may wish to use a candy thermometer, or check with an instant-read thermometer. It may take up to 30 minutes or so to reach a temperature of 218-220˚F (6-8 degrees above boiling at your altitude; I'm close to sea level). After 15 minutes, start checking the temperature frequently.",
      "When the marmalade mixture gets close to 218˚F, you should start testing the set of the jam. I like to use the wrinkle test: put a small bit on one of those chilled saucers, then let it stand in the refrigerator for 1-2 minutes. If it holds its shape, that's a good sign. After those 2 minutes of chilling time, push the blob with your finger. If the sample wrinkles, it's ready to put in jars.",
      "FILL & SEAL THE JARS",
      "Once the marmalade has reached its \"wrinkly\" stage, remove the pot from the heat. Carefully take hot jars from the oven, and stand them on a towel-lined counter Ladle the marmalade into the jars, leaving 1/4 inch head space at the top. Wipe the rims clean with a wet paper towel. Pull the lids from the warm water, place on top of the jars, and secure each with a band, screwing them only finger-tight. Any extra marmalade can go into a clean custard cup; refrigerate this.",
      "Put the sealed jars into the big pot of warm water, and set this pot over high heat. Bring it to a rolling boil. Process for 10 minutes in a boiling water bath. After 10 minutes, remove the jars to a towel-lined counter and let stand undisturbed. Cool the jars completely, label, and store in a dark cool place."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREPARE THE JARS\nThis recipe will make at least 3 8-oz jars, and often a bit more.Gather 3 8-oz jelly jars, and 2 4-oz jars as well. Make sure your jars are sparkling clean. Wash the lids in warm water and set aside. Keep the bands handy. Have an extra small jar, or custard cup, clean and ready for any excess jam.\nPREPARE THE LEMONS\nWash the lemons, discarding any that are moldy or damaged.]\nCut both ends off each lemon. Working one at a time, stand the lemon on end, and cut in half lengthwise. Cut each lemon half into 3 segments, also lengthwise. As you cut these lemon segments, pull off any exposed membranes, if you can, and set them aside. Cut away the pithy core, and remove all seeds. Set aside all the pith and seeds and membranes in a little pile; you'll need them later. Cut each lemon segment crosswise into small pieces, making little truncated triangles of lemon peel and pulp. By the time you've cut all the lemons, you should have 3 cups of little lemon pieces.\nPut all the seeds, membranes, and pith into a tea filter bag, or a bag you've made out of two layers of cheesecloth. Tie the bag shut so none of the seeds can get out. This is your pectin bag.\nCOOK LEMONS & WATER\nPut 3 cups of water into a large, wide pot (I use this 4-qt one) Put the pectin bag into the pot also.\nOver high heat, bring this mixture to a strong boil. Let it boil, uncovered, for 20-25 minutes, until the peels are soft and cooked through. If too much of the water evaporates, and peels start sticking to the bottom of the pan, add a little more water back to the pot. Test one of the lemon peel pieces by eating it: it should be very soft. If it's still chewy, keep cooking. When the peels are soft, remove the pot from the heat. Remove the pectin bag, and put it in a separate bowl. Let it cool until it's comfortable to touch.\nADD PECTIN & SUGAR\nOnce the pectin bag has cooled enough that you can handle it, squeeze it to extract any extra pectin. I like to wear gloves for this part; it's messy. Squeeze the bag thoroughly; you could get about a teaspoon of thickish pectin. Return this to the pot with the lemons and water, and discard the rest of the bag.\nAdd 3 cups of sugar to the water/lemon mixture.\nFINAL COOK: MAKE IT JAM\nPut a small saucer or two in the freezer - you'll use these to test the set of the jam. Put your dry jelly jars, without lids, in a 200˚ oven. This will not only sterilize the jars, but it helps to keep them from cracking due to temperature differential when you add the hot marmalade to them. Put the lids in a glass or ceramic bowl, and pour some boiling water over them. Let this stand as you prepare the jam. Heat a large pot of water -- this will be the pot where you seal the jars. The water must reach more than 1.5 inches over the tops of the jars. The water doesn't need to boil at this point, but it does need to be quite warm.\nPlace the marmalade mixture over medium high heat, and bring it to a rapid boil, stirring occasionally. Make sure nothing sticks to the bottom of the pan. When it first comes to a boil, it will foam up a lot (which is why you need a big pot.) Stir if need be to bring the foam back down. Lower the heat if the mixture threatens to overflow the pot.\nYou may wish to use a candy thermometer, or check with an instant-read thermometer. It may take up to 30 minutes or so to reach a temperature of 218-220˚F (6-8 degrees above boiling at your altitude; I'm close to sea level). After 15 minutes, start checking the temperature frequently.\nWhen the marmalade mixture gets close to 218˚F, you should start testing the set of the jam. I like to use the wrinkle test: put a small bit on one of those chilled saucers, then let it stand in the refrigerator for 1-2 minutes. If it holds its shape, that's a good sign. After those 2 minutes of chilling time, push the blob with your finger. If the sample wrinkles, it's ready to put in jars.\nFILL & SEAL THE JARS\nOnce the marmalade has reached its \"wrinkly\" stage, remove the pot from the heat. Carefully take hot jars from the oven, and stand them on a towel-lined counter Ladle the marmalade into the jars, leaving 1/4 inch head space at the top. Wipe the rims clean with a wet paper towel. Pull the lids from the warm water, place on top of the jars, and secure each with a band, screwing them only finger-tight. Any extra marmalade can go into a clean custard cup; refrigerate this.\nPut the sealed jars into the big pot of warm water, and set this pot over high heat. Bring it to a rolling boil. Process for 10 minutes in a boiling water bath. After 10 minutes, remove the jars to a towel-lined counter and let stand undisturbed. Cool the jars completely, label, and store in a dark cool place.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("goodstuff.recipes")
    expect(recipe.canonical_url).to eq("https://goodstuff.recipes/small-batch-lemon-marmalade/")
    expect(recipe.site_name).to eq("Get the Good Stuff!")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("mlplouff")
    expect(recipe.description).to eq("Just 3 jars of sunny Meyer lemon marmalade")
    expect(recipe.image).to eq("https://goodstuff.recipes/wp-content/uploads/2024/02/Lemon-Marmalade-2.jpg")
    expect(recipe.category).to eq("Jams and Jellies")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["marmalade", "jam", "small batch", "Meyer lemon"])
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
    expect(recipe.links).to include("https://www.pinterest.com/mlplouff/ ")
  end
end
