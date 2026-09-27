# frozen_string_literal: true

RSpec.describe "thermomix-malaga-centro.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_malaga_centro", url: "https://thermomix-malaga-centro.es/yesica-cabello-di-carlo/postres-y-dulces/tiramisu-de-naranja-con-interior-de-crujiente-de-chocolate-negro-y-licor-de-naranjas-amargas") }

  it "reads the title" do
    expect(recipe.title).to eq("Tiramisú de Naranja con interior de crujiente de chocolate negro y licor de naranjas amargas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 huevo",
      "6 yemas",
      "300 gr azúcar",
      "2 sobre de azúcar de vainilla o esencia de vainilla",
      "1 k de queso mascarpone",
      "1 paquete de bizcocho al huevo tipo cuétara",
      "350 gr de chocolate negro Nestlé postres",
      "150 gr de naranja recién exprimida",
      "50 gr de licor Cointreau o Gran Manier( licor de naranjas amargas)",
      "Ralladura de dos naranjas sin nada de parte blanca",
      "1 cucharada de Cacao puro en polvo",
      "Polvo de Naranjas o ralladura de Naranja"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "huevo" },
      { amount: 6.0, unit: nil, name: "yemas" },
      { amount: 300.0, unit: "gr", name: "azúcar" },
      { amount: 2.0, unit: nil, name: "sobre de azúcar de vainilla o esencia de vainilla" },
      { amount: 1.0, unit: nil, name: "k de queso mascarpone" },
      { amount: 1.0, unit: "paquete", name: "bizcocho al huevo tipo cuétara" },
      { amount: 350.0, unit: "gr", name: "chocolate negro Nestlé postres" },
      { amount: 150.0, unit: "gr", name: "naranja recién exprimida" },
      { amount: 50.0, unit: "gr", name: "licor Cointreau o Gran Manier" },
      { amount: nil, unit: nil, name: "Ralladura de dos naranjas sin nada de parte blanca" },
      { amount: 1.0, unit: "cucharada", name: "Cacao puro en polvo" },
      { amount: nil, unit: nil, name: "Polvo de Naranjas o ralladura de Naranja" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "*Coloca la mariposa* en el vaso.Añade 2 huevos,6 yemas,320 gr de azúcar,2 sobres de azúcar de vainilla. Ponga durante 7 min/vel 3'5",
      "Ánade el mascarpone y la ralladura de dos naranjas y mezcle 45seg/vel 3",
      "Coloque lo la bizcochos cubriendo la base en un molde previamente forandonlas paredes y la base con papel de hornear o acetato.Con un pincel calamos un poco los bizcochos con la mezcla del zumo de naranja y el licor de naranjas Amargas.Procurando no calar mucho para que no se rompan los bizcochos.",
      "Seguidamente con un pelador laminamos el chocolate negro de postre y extendemos una ligera capa.Extienda la mitad de la mezcla de mascarpone",
      "Volvemos a colocar otra capa de bizcochos,calamos y ponemos otra capa de láminas de chocolate negroCubrimos con el resto de la crema de mascarpone.Extendemos uniformente.Cubrimos con papel film y dejamos reposar unas 6 horas en la nevera.",
      "Mientras tanto hacemos un baño de chocolate.Y bañamos los bizcochos restantes en chocolate sobre un papel de hornear espolvorear con ralladura de naranja seca o fresca.Dejar solidificar el chocolate y reservar para la decoración.",
      "Una vez pasado el tiempo de reposado espolvoreamos con cacao puro en polvo, ayudándonos de un colador de malla fina.Ponemos la ralladura de naranja seca o recién rallada.Y unos espirales de chocolate negro si se desea.",
      "Colocamos los bizcochos bañados en chocolate negro alrededor de nuestra tarta y envolvemos con un pequeño lazo o cuerda a modo decorativo para mantener sujetos nuestros bizcochos a la tarta."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("*Coloca la mariposa* en el vaso.Añade 2 huevos,6 yemas,320 gr de azúcar,2 sobres de azúcar de vainilla. Ponga durante 7 min/vel 3'5\nÁnade el mascarpone y la ralladura de dos naranjas y mezcle 45seg/vel 3\nColoque lo la bizcochos cubriendo la base en un molde previamente forandonlas paredes y la base con papel de hornear o acetato.Con un pincel calamos un poco los bizcochos con la mezcla del zumo de naranja y el licor de naranjas Amargas.Procurando no calar mucho para que no se rompan los bizcochos.\nSeguidamente con un pelador laminamos el chocolate negro de postre y extendemos una ligera capa.Extienda la mitad de la mezcla de mascarpone\nVolvemos a colocar otra capa de bizcochos,calamos y ponemos otra capa de láminas de chocolate negroCubrimos con el resto de la crema de mascarpone.Extendemos uniformente.Cubrimos con papel film y dejamos reposar unas 6 horas en la nevera.\nMientras tanto hacemos un baño de chocolate.Y bañamos los bizcochos restantes en chocolate sobre un papel de hornear espolvorear con ralladura de naranja seca o fresca.Dejar solidificar el chocolate y reservar para la decoración.\nUna vez pasado el tiempo de reposado espolvoreamos con cacao puro en polvo, ayudándonos de un colador de malla fina.Ponemos la ralladura de naranja seca o recién rallada.Y unos espirales de chocolate negro si se desea.\nColocamos los bizcochos bañados en chocolate negro alrededor de nuestra tarta y envolvemos con un pequeño lazo o cuerda a modo decorativo para mantener sujetos nuestros bizcochos a la tarta.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-malaga-centro.es")
    expect(recipe.canonical_url).to eq("https://thermomix-malaga-centro.es/yesica-cabello-di-carlo/postres-y-dulces/tiramisu-de-naranja-con-interior-de-crujiente-de-chocolate-negro-y-licor-de-naranjas-amargas")
    expect(recipe.site_name).to eq("Thermomix Málaga Centro")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("YESICA CABELLO DI CARLO")
    expect(recipe.description).to eq("Deja volar tu imaginación y da tienda suelta a la presentación también puedes presentarlo en copas individuales... Decorar con flores,fruta ....")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/ec936e7ae2d60341f52f5459c58b7bf3_f2b3ab8652/ec936e7ae2d60341f52f5459c58b7bf3_f2b3ab8652.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Tiramisú de Naranja con interior de crujiente de chocolate negro y licor de naranjas amargas", "Postres y dulces"])
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
    expect(recipe.links).to include("https://blogosferathermomix.es/delegaciones-thermomix")
  end
end
