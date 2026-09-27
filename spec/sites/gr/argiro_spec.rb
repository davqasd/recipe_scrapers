# frozen_string_literal: true

RSpec.describe "argiro.gr" do
  subject(:recipe) { scrape_cassette("gr/argiro", url: "https://www.argiro.gr/recipe/salata-kinoa-pikantiki/") }

  it "reads the title" do
    expect(recipe.title).to eq("Σαλάτα κινόα (πικάντικη)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 φλ. κινόα",
      "1/2 κ.γ. κύμινο",
      "1 κ.σ. πάπρικα καυτερή",
      "Λίγο αλάτι",
      "1 κόκκινο κρεμμύδι (κομμένο σε λεπτές φέτες)",
      "4 φρέσκα κρεμμυδάκια με τα φύλλα τους (ψιλοκομμένα)",
      "4 ντομάτες ώριμες και σφιχτές (ψιλοκομμένες)",
      "1 αγγούρι με τη φλούδα του (σε μικρά καρέ)",
      "2 κίτρινες πιπεριές (σε μικρά καρέ)",
      "1 ματσ. μαϊντανό",
      "Ελαιόλαδο",
      "1 λεμόνι (το χυμό και το ξύσμα του)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "φλ. κινόα" },
      { amount: 0.5, unit: nil, name: "κ.γ. κύμινο" },
      { amount: 1.0, unit: nil, name: "κ.σ. πάπρικα καυτερή" },
      { amount: nil, unit: nil, name: "Λίγο αλάτι" },
      { amount: 1.0, unit: nil, name: "κόκκινο κρεμμύδι" },
      { amount: 4.0, unit: nil, name: "φρέσκα κρεμμυδάκια με τα φύλλα τους" },
      { amount: 4.0, unit: nil, name: "ντομάτες ώριμες και σφιχτές" },
      { amount: 1.0, unit: nil, name: "αγγούρι με τη φλούδα του" },
      { amount: 2.0, unit: nil, name: "κίτρινες πιπεριές" },
      { amount: 1.0, unit: nil, name: "ματσ. μαϊντανό" },
      { amount: nil, unit: nil, name: "Ελαιόλαδο" },
      { amount: 1.0, unit: nil, name: "λεμόνι" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Πρώτα ξεπλένουμε την κινόα σε σουρωτήρι κάτω από τρεχούμενο νερό, πολύ καλά, μέχρι να βγαίνει καθαρό το νερό.",
      "Τη βάζουμε σε κατσαρόλα.",
      "Ρίχνουμε 2 φλ. νερό, τα μπαχαρικά και λίγο αλάτι.",
      "Βράζουμε για 15΄σε χαμηλή φωτιά να φουσκώσει και να σκάσει.",
      "Τη στραγγίζουμε και αφήνουμε να κρυώσει.",
      "Ψιλοκόβουμε τα βότανα και τα βάζουμε σε ένα μπολ.",
      "Προσθέτουμε τη ντομάτα, το αγγούρι, το κρεμμύδι, τις πιπεριές, και την κινόα.",
      "Περιχύνουμε με το ελαιόλαδο, το χυμό και το ξύσμα και αλατίζουμε.",
      "Ανακατεύουμε πολύ καλά και παγώνουμε τη σαλάτα πριν σερβίρουμε.",
      "Αν αγαπάτε την κινόα, δείτε περισσότερες εύκολες, νόστιμες και υγιεινές συνταγές με κινόα εδώ."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Πρώτα ξεπλένουμε την κινόα σε σουρωτήρι κάτω από τρεχούμενο νερό, πολύ καλά, μέχρι να βγαίνει καθαρό το νερό.\nΤη βάζουμε σε κατσαρόλα.\nΡίχνουμε 2 φλ. νερό, τα μπαχαρικά και λίγο αλάτι.\nΒράζουμε για 15΄σε χαμηλή φωτιά να φουσκώσει και να σκάσει.\nΤη στραγγίζουμε και αφήνουμε να κρυώσει.\nΨιλοκόβουμε τα βότανα και τα βάζουμε σε ένα μπολ.\nΠροσθέτουμε τη ντομάτα, το αγγούρι, το κρεμμύδι, τις πιπεριές, και την κινόα.\nΠεριχύνουμε με το ελαιόλαδο, το χυμό και το ξύσμα και αλατίζουμε.\nΑνακατεύουμε πολύ καλά και παγώνουμε τη σαλάτα πριν σερβίρουμε.\nΑν αγαπάτε την κινόα, δείτε περισσότερες εύκολες, νόστιμες και υγιεινές συνταγές με κινόα εδώ.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("argiro.gr")
    expect(recipe.canonical_url).to eq("https://www.argiro.gr/recipe/salata-kinoa-pikantiki/")
    expect(recipe.site_name).to eq("argiro.gr")
    expect(recipe.language).to eq("el")
    expect(recipe.author).to eq("Αργυρώ Μπαρμπαρίγου")
    expect(recipe.description).to eq("Σαλάτα κινόα, για εσάς που προσέχετε τη διατροφή σας αλλά σας αρέσουν οι νοστιμιές και για εσάς που θέλετε να δοκιμάζετε καινούριες γεύσεις")
    expect(recipe.image).to eq("https://www.argiro.gr/wp-content/uploads/2019/05/salata-kinoa.jpg")
    expect(recipe.category).to eq("ΣΑΛΑΤΕΣ")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[ΚΙΝΟΑ ΣΑΛΑΤΕΣ SUPERFOODS ΚΑΤΣΑΡΟΛΑ])
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
    expect(recipe.links).to include("https://www.argiro.gr")
  end
end
