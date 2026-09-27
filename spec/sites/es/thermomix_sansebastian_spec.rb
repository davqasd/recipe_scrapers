# frozen_string_literal: true

RSpec.describe "thermomix-sansebastian.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_sansebastian", url: "https://thermomix-sansebastian.es/m-pilar-meira-dominguez/dietas-especiales/galletas-de-calabaza-con-pepitas-de-chocolate-a-mi-manera") }

  it "reads the title" do
    expect(recipe.title).to eq("Galletas de calabaza con pepitas de chocolate a mi manera")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 g de trigo sarraceno",
      "100 de quinoa",
      "20g de lino",
      "1/2 cucharadita de levadura en polvo",
      "1/2 cucharadita de bicarbonato sodico",
      "1 pellizcó de sal",
      "3/4 cucharadita de nuez moscada molida",
      "1 pizca de jengibre en polvo",
      "110 g de mantequilla a temperatura ambiente",
      "50g de azúcar moreno",
      "100g de azúcar o eritritol",
      "1 cucharada de vainilla liquida",
      "100 g de calabaza",
      "100 g de permitas de chocolate sin azucar",
      "2 huevos"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "trigo sarraceno" },
      { amount: 100.0, unit: nil, name: "quinoa" },
      { amount: 20.0, unit: "g", name: "lino" },
      { amount: 0.5, unit: "cucharadita", name: "levadura en polvo" },
      { amount: 0.5, unit: "cucharadita", name: "bicarbonato sodico" },
      { amount: 1.0, unit: nil, name: "pellizcó de sal" },
      { amount: 0.75, unit: "cucharadita", name: "nuez moscada molida" },
      { amount: 1.0, unit: "pizca", name: "jengibre en polvo" },
      { amount: 110.0, unit: "g", name: "mantequilla a temperatura ambiente" },
      { amount: 50.0, unit: "g", name: "azúcar moreno" },
      { amount: 100.0, unit: "g", name: "azúcar o eritritol" },
      { amount: 1.0, unit: "cucharada", name: "vainilla liquida" },
      { amount: 100.0, unit: "g", name: "calabaza" },
      { amount: 100.0, unit: "g", name: "permitas de chocolate sin azucar" },
      { amount: 2.0, unit: nil, name: "huevos" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Añadimos 500 g de agua al vaso , colocamos en cestillo en el vaso y añadimos la calabaza . Ponemos la tapa y el cubilete y programamos 10 mi/110º/ vel 2. Retiramos el cestillo ,vaciamos el vaso y añadimos la calabaza al vaso. Trituramos 5seg/vel 8. Reservamos",
      "Añadimos al vaso el trigo sarraceno , la quinoa y el lino . ( si las hacemos de harina de trigo , añadiremos 220 g de harina) Ponemos la tapa y trituramos 30 seg/ vel10. Añadimos la levadura, el bicarbonato, la sal , la canela, la nuez moscada y el jengibre. Programaremos 10seg/vel7 . Reservamos en un bol.",
      "Sin lavar el vaso , añadimos la mantequilla, el xilitol o azúcar y los 2 huevos y programamos 3 min//37º / vel 2 y 1/2. Añadimos la vainilla y el puré de calabaza, programamos1min/vel 3 1/2. Terminamos de mezclar con la espatula. Agregamos la mezcla de harina y programamos 1min/vel 3Añadimos las permitas de chocolate y mezclamos con la espátula",
      "Precalentamos el horno a 180º . Mientras preparamos 2 bandejas de horno con papel encerado . Con 2 cucharillas vamos cogiendo masa del vaso y añadiendo a las bandejas , aplastar un poco . Metemos al horno y horneamos durante 10/12 min.Sacamos del horno y dejamos enfriar sobre una rejilla ."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Añadimos 500 g de agua al vaso , colocamos en cestillo en el vaso y añadimos la calabaza . Ponemos la tapa y el cubilete y programamos 10 mi/110º/ vel 2. Retiramos el cestillo ,vaciamos el vaso y añadimos la calabaza al vaso. Trituramos 5seg/vel 8. Reservamos\nAñadimos al vaso el trigo sarraceno , la quinoa y el lino . ( si las hacemos de harina de trigo , añadiremos 220 g de harina) Ponemos la tapa y trituramos 30 seg/ vel10. Añadimos la levadura, el bicarbonato, la sal , la canela, la nuez moscada y el jengibre. Programaremos 10seg/vel7 . Reservamos en un bol.\nSin lavar el vaso , añadimos la mantequilla, el xilitol o azúcar y los 2 huevos y programamos 3 min//37º / vel 2 y 1/2. Añadimos la vainilla y el puré de calabaza, programamos1min/vel 3 1/2. Terminamos de mezclar con la espatula. Agregamos la mezcla de harina y programamos 1min/vel 3Añadimos las permitas de chocolate y mezclamos con la espátula\nPrecalentamos el horno a 180º . Mientras preparamos 2 bandejas de horno con papel encerado . Con 2 cucharillas vamos cogiendo masa del vaso y añadiendo a las bandejas , aplastar un poco . Metemos al horno y horneamos durante 10/12 min.Sacamos del horno y dejamos enfriar sobre una rejilla .")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-sansebastian.es")
    expect(recipe.canonical_url).to eq("https://thermomix-sansebastian.es/m-pilar-meira-dominguez/dietas-especiales/galletas-de-calabaza-con-pepitas-de-chocolate-a-mi-manera")
    expect(recipe.site_name).to eq("Thermomix San Sebastián")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("M PILAR MEIRA DOMINGUEZ")
    expect(recipe.description).to eq("Cuando sacas las galletas del horno salen muy blanditas por lo que hay que tener cuidado de que no se rompan . Una vez que se enfrían se van endureciendo .")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/a75b2befbff33485d11de9f0720a524d_e968209343/a75b2befbff33485d11de9f0720a524d_e968209343.jpg")
    expect(recipe.category).to eq("Dietas especiales")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Galletas de calabaza con pepitas de chocolate a mi manera", "Dietas especiales"])
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
