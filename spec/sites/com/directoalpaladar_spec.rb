# frozen_string_literal: true

RSpec.describe "directoalpaladar.com" do
  subject(:recipe) { scrape_cassette("com/directoalpaladar", url: "https://www.directoalpaladar.com/recetas-con-thermomix/receta-de-salmorejo-cordobes-con-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("Receta de salmorejo cordobés con Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1kg Tomate",
      "2count Dientes de ajo",
      "150g Pan blanco",
      "5g Vinagre",
      "100g Aceite de oliva virgen extra",
      "Sal"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "Tomate" },
      { amount: 2.0, unit: "count", name: "Dientes de ajo" },
      { amount: 150.0, unit: "g", name: "Pan blanco" },
      { amount: 5.0, unit: "g", name: "Vinagre" },
      { amount: 100.0, unit: "g", name: "Aceite de oliva virgen extra" },
      { amount: nil, unit: nil, name: "Sal" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Lavamos bien los tomates y retiramos las partes por las que van unidos al pedúnculo. Los cortamos por la mitad y los colocamos en el vaso. Pelamos los dientes de ajo y retiramos el germen interior, **con esto suavizamos su sabor**, y los agregamos al vaso. Programamos 30 segundos, velocidad 5.",
      "Añadimos el pan blanco troceado (también podemos usar miga de pan) al vaso, el vinagre y sazonamos al gusto. Trituramos durante 30 segundos, velocidad 5. Bajamos los restos de las paredes y programamos de nuevo **cinco minutos a velocidad 10**.",
      "Durante este tiempo vertemos el aceite de oliva virgen extra por el bocal, sin retirar el vaso, **para que caiga poco a poco**. Con esto conseguimos que la mezcla emulsione y obtenemos una textura aterciopelada y cremosa inigualable. La fricción sube la temperatura del salmorejo, así que guardamos en la nevera hasta el momento de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Lavamos bien los tomates y retiramos las partes por las que van unidos al pedúnculo. Los cortamos por la mitad y los colocamos en el vaso. Pelamos los dientes de ajo y retiramos el germen interior, **con esto suavizamos su sabor**, y los agregamos al vaso. Programamos 30 segundos, velocidad 5.\nAñadimos el pan blanco troceado (también podemos usar miga de pan) al vaso, el vinagre y sazonamos al gusto. Trituramos durante 30 segundos, velocidad 5. Bajamos los restos de las paredes y programamos de nuevo **cinco minutos a velocidad 10**.\nDurante este tiempo vertemos el aceite de oliva virgen extra por el bocal, sin retirar el vaso, **para que caiga poco a poco**. Con esto conseguimos que la mezcla emulsione y obtenemos una textura aterciopelada y cremosa inigualable. La fricción sube la temperatura del salmorejo, así que guardamos en la nevera hasta el momento de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("directoalpaladar.com")
    expect(recipe.canonical_url).to eq("https://www.directoalpaladar.com/recetas-con-thermomix/receta-de-salmorejo-cordobes-con-thermomix")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Carmen Tía Alia")
    expect(recipe.description).to eq("Te explicamos paso a paso, de manera sencilla y para thermomix, la elaboración de la receta de salmorejo cordobés. Ingredientes, tiempo de elaboración")
    expect(recipe.image).to eq("https://i.blogs.es/b1f740/salmorejo_thermomix/650_1200.jpg")
    expect(recipe.category).to eq("Recetas con Thermomix")
    expect(recipe.cuisine).to eq("española")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "sopa fría",
      "Thermomix",
      "receta tradicional",
      "Recetas de verano",
      "Recetas en menos de 30 minutos",
      "Recetas fáciles y rápidas",
      "Frigoríficos LG",
      "Recetas con Thermomix",
      "Recetas de Sopas y cremas"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.92084)
    expect(recipe.ratings_count).to eq(379)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.webedia.es/")
  end
end
