# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::Microdata do
  def build(body)
    described_class.new(Nokogiri::HTML5("<html><body>#{body}</body></html>"))
  end

  it "reads the type from the last segment of the itemtype url" do
    reader = build('<div itemscope itemtype="http://schema.org/Recipe"><h1 itemprop="name">Borscht</h1></div>')
    expect(reader.recipe["@type"]).to eq("Recipe")
  end

  it "takes the type even when the host carries a www prefix" do
    reader = build('<div itemscope itemtype="http://www.schema.org/Recipe"><h1 itemprop="name">Borscht</h1></div>')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "returns nil when no element declares a recipe" do
    reader = build('<div itemscope itemtype="https://schema.org/Article"><h1 itemprop="name">News</h1></div>')
    expect(reader.recipe).to be_nil
  end

  it "collects a repeated property into a list" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <li itemprop="recipeIngredient">400 g kale</li>
        <li itemprop="recipeIngredient">1 clove garlic</li>
      </div>
    HTML
    expect(reader.recipe["recipeIngredient"]).to eq(["400 g kale", "1 clove garlic"])
  end

  it "keeps a property that appears once as a single value" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe"><li itemprop="recipeIngredient">400 g kale</li></div>
    HTML
    expect(reader.recipe["recipeIngredient"]).to eq("400 g kale")
  end

  it "assigns one element to each name when itemprop lists several" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <meta itemprop="image thumbnailUrl" content="https://example.com/a.jpg">
      </div>
    HTML
    expect(reader.recipe.values_at("image", "thumbnailUrl")).to eq(["https://example.com/a.jpg"] * 2)
  end

  it "nests an item that carries both itemprop and itemscope" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <span itemprop="nutrition" itemscope itemtype="https://schema.org/NutritionInformation">
          <span itemprop="calories">730</span>
        </span>
      </div>
    HTML
    expect(reader.recipe["nutrition"]).to eq({ "@type" => "NutritionInformation", "calories" => "730" })
  end

  it "keeps a nested item's properties out of the enclosing item" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <span itemprop="nutrition" itemscope itemtype="https://schema.org/NutritionInformation">
          <span itemprop="calories">730</span>
        </span>
      </div>
    HTML
    expect(reader.recipe).not_to have_key("calories")
  end

  it "reads the value of a meta element from its content attribute" do
    reader = build('<div itemscope itemtype="https://schema.org/Recipe"><meta itemprop="name" content="Borscht"></div>')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "reads the value of a time element from its datetime attribute" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <time itemprop="totalTime" datetime="PT30M">30 mins</time>
      </div>
    HTML
    expect(reader.recipe["totalTime"]).to eq("PT30M")
  end

  it "reads the value of an anchor from its href attribute" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <a itemprop="url" href="https://example.com/borscht">Borscht</a>
      </div>
    HTML
    expect(reader.recipe["url"]).to eq("https://example.com/borscht")
  end

  it "reads the value of an image from its src attribute" do
    reader = build('<div itemscope itemtype="https://schema.org/Recipe"><img itemprop="image" src="/a.jpg"></div>')
    expect(reader.recipe["image"]).to eq("/a.jpg")
  end

  it "prefers a content attribute on an ordinary element over its text" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <span itemprop="totalTime" content="PT30M">half an hour</span>
      </div>
    HTML
    expect(reader.recipe["totalTime"]).to eq("PT30M")
  end

  it "falls back to the element text when nothing carries the value" do
    reader = build('<div itemscope itemtype="https://schema.org/Recipe"><h1 itemprop="name"> Borscht </h1></div>')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "leaves script contents out of a text value" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <div itemprop="recipeInstructions">Boil it<script>var ads = 1;</script></div>
      </div>
    HTML
    expect(reader.recipe["recipeInstructions"]).to eq("Boil it")
  end

  it "separates block children of a text value onto their own lines" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <div itemprop="recipeInstructions"><p>Boil it</p><p>Serve it</p></div>
      </div>
    HTML
    expect(reader.recipe["recipeInstructions"]).to eq("Boil it\nServe it")
  end

  it "breaks between table cells that sit side by side with no whitespace" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <table><tr itemprop="recipeIngredient"><td><span>400 g</span></td><th>kale</th></tr></table>
      </div>
    HTML
    expect(reader.recipe["recipeIngredient"]).to eq("400 g\nkale")
  end

  it "keeps an inline child inside the surrounding line" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Recipe">
        <p itemprop="description">Boil the <strong>kale</strong> gently</p>
      </div>
    HTML
    expect(reader.recipe["description"]).to eq("Boil the kale gently")
  end

  it "finds a recipe nested inside an unrelated outer item" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/WebPage">
        <div itemprop="mainEntity" itemscope itemtype="https://schema.org/Recipe">
          <h1 itemprop="name">Borscht</h1>
        </div>
      </div>
    HTML
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "reads the website name" do
    reader = build('<div itemscope itemtype="https://schema.org/WebSite"><span itemprop="name"> Eda </span></div>')
    expect(reader.website_name).to eq("Eda")
  end

  it "indexes a person by the itemid so an author reference resolves" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/Person" itemid="#nagi">
        <span itemprop="name">Nagi</span>
      </div>
    HTML
    expect(reader.person("#nagi")["name"]).to eq("Nagi")
  end

  it "indexes an aggregate rating by the itemid" do
    reader = build(<<~HTML)
      <div itemscope itemtype="https://schema.org/AggregateRating" itemid="#r">
        <span itemprop="ratingCount">12</span>
      </div>
    HTML
    expect(reader.rating("#r")["ratingCount"]).to eq("12")
  end

  context "as the fallback behind json-ld" do
    def schema(body)
      document = Nokogiri::HTML5("<html><body>#{body}</body></html>")
      RecipeScrapers::Sources::SchemaOrg.new(
        RecipeScrapers::Sources::JsonLd.new(document),
        described_class.new(document)
      )
    end

    let(:markup) do
      <<~HTML
        <script type="application/ld+json">
        {"@context":"https://schema.org","@type":"Recipe","name":"From json-ld",
         "recipeIngredient":["400 g kale"]}
        </script>
        <div itemscope itemtype="https://schema.org/Recipe">
          <h1 itemprop="name">From microdata</h1>
          <li itemprop="recipeIngredient">1 clove garlic</li>
        </div>
      HTML
    end

    it "prefers the json-ld recipe when a page publishes both" do
      expect(schema(markup).title).to eq("From json-ld")
    end

    it "reads the microdata recipe when the page has no json-ld" do
      expect(schema(markup.sub(%r{<script.*?</script>}m, "")).title).to eq("From microdata")
    end

    it "takes the legacy ingredients property when recipeIngredient is absent" do
      body = <<~HTML
        <div itemscope itemtype="https://schema.org/Recipe">
          <h1 itemprop="name">Pesto</h1>
          <li itemprop="ingredients">2 cloves garlic</li>
        </div>
      HTML
      expect(schema(body).ingredients).to eq(["2 cloves garlic"])
    end
  end
end
