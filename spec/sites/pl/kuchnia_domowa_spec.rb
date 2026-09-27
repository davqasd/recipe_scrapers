# frozen_string_literal: true

RSpec.describe "kuchnia-domowa.pl" do
  subject(:recipe) { scrape_cassette("pl/kuchnia_domowa", url: "https://www.kuchnia-domowa.pl/dania-male/667-niskoweglowodanowy-wrap-z-baklazana") }

  it "reads the title" do
    expect(recipe.title).to eq("Niskowęglowodanowy wrap z bakłażana")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 duży bakłażan",
      "ok. 160 g tartej mozzarelli",
      "pesto",
      "serek kremowy, najlepiej smakowy, np. ziołowy",
      "pomidor",
      "mozzarella (1 kulka)",
      "½ dojrzałego awokado",
      "rukola",
      "plasterki szynki",
      "sól (zwykła lub ziołowa)",
      "świeżo mielony czarny pieprz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "duży bakłażan" },
      { amount: nil, unit: nil, name: "ok. 160 g tartej mozzarelli" },
      { amount: nil, unit: nil, name: "pesto" },
      { amount: nil, unit: nil, name: "serek kremowy, najlepiej smakowy, np. ziołowy" },
      { amount: nil, unit: nil, name: "pomidor" },
      { amount: nil, unit: nil, name: "mozzarella" },
      { amount: 0.5, unit: nil, name: "dojrzałego awokado" },
      { amount: nil, unit: nil, name: "rukola" },
      { amount: nil, unit: nil, name: "plasterki szynki" },
      { amount: nil, unit: nil, name: "sól" },
      { amount: nil, unit: nil, name: "świeżo mielony czarny pieprz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Piekarnik nagrzać do temperatury 200°C, grzałka góra-dół.",
      "Bakłażana umyć, osuszyć, odciąć końce i pokroić w bardzo cienkie plasterki.",
      "Plasterki układać na blasze wyłożonej papierem do pieczenia, lekko nakładając je na siebie, tak aby stworzyły jeden większy prostokąt.",
      "Całość oprószyć solą i pieprzem.",
      "Następnie równomiernie posypać startą mozzarellą. (Używam ok. 160 g sera - nie warto dawać mniej, ponieważ po roztopieniu ser skleja plasterki bakłażana i dzięki temu wrap dobrze trzyma się po upieczeniu. Poza tym zapieczony ser dodaje daniu smaku i przyjemnej chrupkości).",
      "Piec w nagrzanym piekarniku przez ok. 20 minut, aż ser mocno się zarumieni. Dzięki temu będzie lekko chrupiący i bardziej stabilny. Pod koniec pieczenia najlepiej obserwować wrap, aby ser był dobrze przypieczony, ale nie spalony.",
      "Gotowy wrap wyciągnąć z piekarnika i pozostawić na kilka minut do lekkiego przestudzenia. To ważny etap - tuż po upieczeniu wrap jest bardzo miękki i delikatny, dlatego może się rozpadać podczas przewracania i zwijania. Może pozostać lekko ciepły, ale nie powinien być gorący.",
      "Następnie odwrócić wrap na drugą stronę, czyli serem do dołu. Najłatwiej przełożyć go razem z papierem do pieczenia na blachę (może być ta, na której się piekł) lub dużą deskę, odwrócić i delikatnie ściągnąć papier.",
      "Powierzchnię wrapa posmarować pesto lub serkiem kremowym. (Ja polecam posmarować połowę pesto, a drugą połowę serkiem kremowym - dzięki temu wychodzą dwa różne smaki).",
      "Wzdłuż jednego krótszego boku ułożyć wybrane dodatki, np. plasterki mozzarelli, pomidora, awokado, rukolę czy szynkę.",
      "Całość ciasno zwinąć w rulon.",
      "Pokroić na 2- 3 części i podawać."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 2],
        ["Ulubione dodatki (przykładowo)", 9]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Piekarnik nagrzać do temperatury 200°C, grzałka góra-dół.\nBakłażana umyć, osuszyć, odciąć końce i pokroić w bardzo cienkie plasterki.\nPlasterki układać na blasze wyłożonej papierem do pieczenia, lekko nakładając je na siebie, tak aby stworzyły jeden większy prostokąt.\nCałość oprószyć solą i pieprzem.\nNastępnie równomiernie posypać startą mozzarellą. (Używam ok. 160 g sera - nie warto dawać mniej, ponieważ po roztopieniu ser skleja plasterki bakłażana i dzięki temu wrap dobrze trzyma się po upieczeniu. Poza tym zapieczony ser dodaje daniu smaku i przyjemnej chrupkości).\nPiec w nagrzanym piekarniku przez ok. 20 minut, aż ser mocno się zarumieni. Dzięki temu będzie lekko chrupiący i bardziej stabilny. Pod koniec pieczenia najlepiej obserwować wrap, aby ser był dobrze przypieczony, ale nie spalony.\nGotowy wrap wyciągnąć z piekarnika i pozostawić na kilka minut do lekkiego przestudzenia. To ważny etap - tuż po upieczeniu wrap jest bardzo miękki i delikatny, dlatego może się rozpadać podczas przewracania i zwijania. Może pozostać lekko ciepły, ale nie powinien być gorący.\nNastępnie odwrócić wrap na drugą stronę, czyli serem do dołu. Najłatwiej przełożyć go razem z papierem do pieczenia na blachę (może być ta, na której się piekł) lub dużą deskę, odwrócić i delikatnie ściągnąć papier.\nPowierzchnię wrapa posmarować pesto lub serkiem kremowym. (Ja polecam posmarować połowę pesto, a drugą połowę serkiem kremowym - dzięki temu wychodzą dwa różne smaki).\nWzdłuż jednego krótszego boku ułożyć wybrane dodatki, np. plasterki mozzarelli, pomidora, awokado, rukolę czy szynkę.\nCałość ciasno zwinąć w rulon.\nPokroić na 2- 3 części i podawać.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kuchnia-domowa.pl")
    expect(recipe.canonical_url).to eq("https://kuchnia-domowa.pl/dania-male/667-niskoweglowodanowy-wrap-z-baklazana")
    expect(recipe.site_name).to eq("Kuchnia Domowa")
    expect(recipe.language).to eq("pl-pl")
    expect(recipe.author).to eq("Kuchnia Domowa")
    expect(recipe.description).to eq("Wrap z bakłażana to świetna alternatywa dla klasycznej tortilli - bez mąki, bez glutenu i z niewielką ilością węglowodanów. Zamiast placka tortilla wykorzystuje się cienkie plasterki bakłażana zapieczone z serem żółtym. To właśnie one tworzą bazę naszego wrapa.")
    expect(recipe.image).to eq("https://kuchnia-domowa.pl/images/content/667/wrap_z_baklazana_niskoweglowodanowy.webp")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["wrap z bakłażana", "niskowęglowodanowy wrap", "wrap bez mąki", "wrap bez glutenu", "keto wrap z bakłażana", "wrapłażan", "bakłażan z mozzarellą", "bakłażanowa tortilla", "tortilla z bakłażana", "fit wrap warzywny", "zdrowy wrap na obiad", "low carb wrap", "pieczony bakłażan z serem", "wrap keto", "przepis z bakłażana", "warzywny wrap", "lekki obiad low carb", "bakłażan zapiekany z serem"])
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
    expect(recipe.links).to include("https://facebook.com/KuchniaDomowaPL")
  end
end
