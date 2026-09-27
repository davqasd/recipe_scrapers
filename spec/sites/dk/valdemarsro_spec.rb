# frozen_string_literal: true

RSpec.describe "valdemarsro.dk" do
  subject(:recipe) { scrape_cassette("dk/valdemarsro", url: "https://www.valdemarsro.dk/langtidssimret-chili-con-carne-med-bov/") }

  it "reads the title" do
    expect(recipe.title).to eq("Langtidssimret chili con carne")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 kg oksebov",
      "2 løg, finthakkede",
      "2 fed hvidløg, finthakket",
      "2 tsk stødt spidskommen",
      "1 tsk stødt kanel",
      "2 tsk stødt koriander",
      "½ tsk chiliflager",
      "400 g hakkede tomater på dåse",
      "30 g soltørrede tomater i olie, finthakket",
      "3 dl oksebouillon",
      "1 dåse kidneybønner, drænede og skyllede",
      "40 g mørk chokolade",
      "3 spsk olivenolie, til stegning",
      "salt og friskkværnet peber",
      "125 g nachos",
      "3 dl ris",
      "2 dl cremefraiche 18 %",
      "150 g cheddar",
      "1 håndfuld frisk koriander",
      "1 rød chili, finthakket"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "oksebov" },
      { amount: 2.0, unit: nil, name: "løg, finthakkede" },
      { amount: 2.0, unit: nil, name: "fed hvidløg, finthakket" },
      { amount: 2.0, unit: "tsk", name: "stødt spidskommen" },
      { amount: 1.0, unit: "tsk", name: "stødt kanel" },
      { amount: 2.0, unit: "tsk", name: "stødt koriander" },
      { amount: 0.5, unit: "tsk", name: "chiliflager" },
      { amount: 400.0, unit: "g", name: "hakkede tomater på dåse" },
      { amount: 30.0, unit: "g", name: "soltørrede tomater i olie, finthakket" },
      { amount: 3.0, unit: "dl", name: "oksebouillon" },
      { amount: 1.0, unit: nil, name: "dåse kidneybønner, drænede og skyllede" },
      { amount: 40.0, unit: "g", name: "mørk chokolade" },
      { amount: 3.0, unit: "spsk", name: "olivenolie, til stegning" },
      { amount: nil, unit: nil, name: "salt og friskkværnet peber" },
      { amount: 125.0, unit: "g", name: "nachos" },
      { amount: 3.0, unit: "dl", name: "ris" },
      { amount: 2.0, unit: "dl", name: "cremefraiche 18 %" },
      { amount: 150.0, unit: "g", name: "cheddar" },
      { amount: 1.0, unit: nil, name: "håndfuld frisk koriander" },
      { amount: 1.0, unit: nil, name: "rød chili, finthakket" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Skær kødet i tykke skiver (jeg deler en oksebov på 800 g i 3-4 skiver).",
      "Varm en støbejernsgryde op med olie ved høj varme og brun kødet godt på alle sider. Tag kødet op af gryden, sæt det til side på en tallerken og skrue ned for varmen på gryden. Tilsæt løg, hvidløg, spidskommen, kanel, koriander og chili i gryden og sauter nogle minutter til løgene er bløde.",
      "Kom kødet tilbage i gryden sammen med hakkede tomater, soltørrede tomater og oksebouillon. Læg låg på, kog langsomt op til kogepunktet, juster derefter temperaturen til, så det blot akkurat netop simrer svagt. Lad retten simre i gryden med låg i 3-4 timer til kødet er mørt som smør.",
      "Tag kødet op af gryden og trævl det med to gafler. Kom det trævlede kød tilbage i gryden og rør retten godt sammen. Smag godt til, med salt, peber og evt mere chili efter smag. Tilsæt bønner og varm retten godt igennem i 5 minutter.",
      "Tag gryden af varmen og rør først halvdelen af chokoladen i og smag til med resten af chokoladen. Smag igen retten til.",
      "Server med nachos, ris, godt brød, creme fraiche og gratiner evt med cheddarost."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Skær kødet i tykke skiver (jeg deler en oksebov på 800 g i 3-4 skiver).\nVarm en støbejernsgryde op med olie ved høj varme og brun kødet godt på alle sider. Tag kødet op af gryden, sæt det til side på en tallerken og skrue ned for varmen på gryden. Tilsæt løg, hvidløg, spidskommen, kanel, koriander og chili i gryden og sauter nogle minutter til løgene er bløde.\nKom kødet tilbage i gryden sammen med hakkede tomater, soltørrede tomater og oksebouillon. Læg låg på, kog langsomt op til kogepunktet, juster derefter temperaturen til, så det blot akkurat netop simrer svagt. Lad retten simre i gryden med låg i 3-4 timer til kødet er mørt som smør.\nTag kødet op af gryden og trævl det med to gafler. Kom det trævlede kød tilbage i gryden og rør retten godt sammen. Smag godt til, med salt, peber og evt mere chili efter smag. Tilsæt bønner og varm retten godt igennem i 5 minutter.\nTag gryden af varmen og rør først halvdelen af chokoladen i og smag til med resten af chokoladen. Smag igen retten til.\nServer med nachos, ris, godt brød, creme fraiche og gratiner evt med cheddarost.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("valdemarsro.dk")
    expect(recipe.canonical_url).to eq("https://www.valdemarsro.dk/langtidssimret-chili-con-carne-med-bov/")
    expect(recipe.site_name).to eq("Valdemarsro")
    expect(recipe.language).to eq("da")
    expect(recipe.author).to eq("Ann-Christine Hellerup Brandt")
    expect(recipe.description).to eq("Langtidssimret chili con carne af oksebov er virkelig lækkert og en dejlig simreret, som jeg på det varmeste kan anbefale at begive sig ud i. Sådan en simreret kræver simrekød, og resultatet bliver det møreste kød, man kan ønske sig. Jeg river det fra hinanden – ala pulled pork – og der er så meget smag, smovs og dejlighed i denne ret. Selv om retten tager lang tid at lave, så kræver den kort arbejdstid i køkkenet og den passer stort set sig selv. Genial som en uhøjtidelig gæstemad og til hyggestunder. Server helt klassisk med ris, nachos, cremefraiche og krydderurter – og lav gerne en stor portion, så der også er til fryseren. Prøv også: opskrift på nem chili con carne >> Langtidssimret chili con carne Tid i alt 4 timer Arbejdstid 30 min. Antal 4 pers. Holdbarhed 2 dage Kan fryses Ja Vil du gerne have billede på udskriften? Som medlem af VALDEMARSRO Premium får du adgang til en masse ekstra fordele, blandt andet kan du få billede med, når du printer opskrifter og undgå forstyrrende reklamer. Læs mere på Valdemarsro om alle fordelene. PT4HPT30M4 Langtidssimret chili con carne Tid i alt4 timer Arbejdstid30 min. Holdbarhed2 dage Kan frysesJa Antal4 pers. Hold min skærm tændt, mens jeg laver mad Ingredienser 1 kg oksebov 2 løg, finthakkede 2 fed hvidløg, finthakket 2 tsk stødt spidskommen 1 tsk stødt kanel 2 tsk stødt koriander ½ tsk chiliflager 400 g hakkede tomater på dåse 30 g soltørrede tomater i olie, finthakket 3 dl oksebouillon 1 dåse kidneybønner, drænede og skyllede 40 g mørk chokolade 3 spsk olivenolie, til stegning salt og friskkværnet peber Til servering 125 g nachos 3 dl ris 2 dl cremefraiche 18 % 150 g cheddar 1 håndfuld frisk koriander 1 rød chili, finthakket Fremgangsmåde Skær kødet i tykke skiver (jeg deler en oksebov på 800 g i 3-4 skiver). Varm en støbejernsgryde op med olie ved høj varme og brun kødet godt på alle sider. Tag kødet op af gryden, sæt det til side på en tallerken og skrue ned for varmen på gryden. Tilsæt løg, hvidløg, spidskommen, kanel, koriander og chili i gryden og sauter nogle minutter til løgene er bløde. Kom kødet tilbage i gryden sammen med hakkede tomater, soltørrede tomater og oksebouillon. Læg låg på, kog langsomt op til kogepunktet, juster derefter temperaturen til, så det blot akkurat netop simrer svagt. Lad retten simre i gryden med låg i 3-4 timer til kødet er mørt som smør. Tag kødet op af gryden og trævl det med to gafler. Kom det trævlede kød tilbage i gryden og rør retten godt sammen. Smag godt til, med salt, peber og evt mere chili efter smag. Tilsæt bønner og varm retten godt igennem i 5 minutter. Tag gryden af varmen og rør først halvdelen af chokoladen i og smag til med resten af chokoladen. Smag igen retten til. Server med nachos, ris, godt brød, creme fraiche og gratiner evt med cheddarost. Føj til indkøbsseddel Sæt på madplan Føj til favoritter Udskriv Send Hold min skærm tændt, mens jeg laver mad")
    expect(recipe.image).to eq("https://www.valdemarsro.dk/wp-content/2023/08/langtidssimret-chili-carne-bov.jpg")
    expect(recipe.category).to eq("Aftensmad")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(240)
    expect(recipe.keywords).to eq(%w[Gryderetter Mexicansk Simremad])
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
    expect(recipe.links).to include("#comment-280568")
  end
end
