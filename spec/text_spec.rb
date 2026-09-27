# frozen_string_literal: true

RSpec.describe RecipeScrapers::Text do
  it "collapses runs of whitespace" do
    expect(described_class.normalize("a   b\n\tc")).to eq("a b c")
  end

  it "replaces a non breaking space" do
    expect(described_class.normalize("100 g")).to eq("100 g")
  end

  it "unescapes entities" do
    expect(described_class.normalize("salt &amp; pepper")).to eq("salt & pepper")
  end

  it "returns nil for blank input" do
    expect(described_class.normalize("   ")).to be_nil
  end

  it "collapses doubled parentheses when the string carries both halves" do
    expect(described_class.normalize("1/4 tsp cayenne ((optional))")).to eq("1/4 tsp cayenne (optional)")
  end

  it "leaves a lone doubled bracket alone" do
    expect(described_class.normalize("((a")).to eq("((a")
  end

  it "strips html tags" do
    expect(described_class.normalize("400 g <b>kale</b>")).to eq("400 g kale")
  end

  it "unescapes an entity that was escaped twice" do
    expect(described_class.normalize("salt &amp;amp; pepper")).to eq("salt & pepper")
  end

  it "collapses unicode whitespace, not only ascii" do
    expect(described_class.normalize("1\u2009\u00BD teaspoons")).to eq("1 \u00BD teaspoons")
  end

  it "unescapes a named entity beyond the basic five" do
    expect(described_class.normalize("280 g L&ouml;ffelbiskuit")).to eq("280 g Löffelbiskuit")
  end

  it "drops a zero width space" do
    expect(described_class.normalize("400\u200bg")).to eq("400g")
  end

  it "drops the blank braille pattern some sites pad lines with" do
    expect(described_class.normalize("\u00bd onion, chopped\u2800")).to eq("\u00bd onion, chopped")
  end

  describe ".content" do
    def node(html) = Nokogiri::HTML5.fragment(html).children.first

    it "reads the text of an element" do
      expect(described_class.content(node("<p>Fry the onion</p>"))).to eq("Fry the onion")
    end

    it "reads through nested elements" do
      expect(described_class.content(node("<p>Fry the <b>onion</b></p>"))).to eq("Fry the onion")
    end

    it "leaves out a script the site put inside the element" do
      html = %(<div>Fry the onion<script>if (a < b) { render("ad"); }</script></div>)
      expect(described_class.content(node(html))).to eq("Fry the onion")
    end

    it "leaves out a script nested deeper in the element" do
      html = %(<div><p>Fry the onion<script>render("ad")</script></p></div>)
      expect(described_class.content(node(html))).to eq("Fry the onion")
    end

    it "leaves out styles, templates and noscript blocks", :aggregate_failures do
      expect(described_class.content(node("<div>Salt<style>a{}</style></div>"))).to eq("Salt")
      expect(described_class.content(node("<div>Salt<template>gone</template></div>"))).to eq("Salt")
      expect(described_class.content(node("<div>Salt<noscript>gone</noscript></div>"))).to eq("Salt")
    end

    it "returns nil for no node" do
      expect(described_class.content(nil)).to be_nil
    end

    it "returns nil for a script node itself" do
      expect(described_class.content(node("<script>render()</script>"))).to be_nil
    end
  end
end
