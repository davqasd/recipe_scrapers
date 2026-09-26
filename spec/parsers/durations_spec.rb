# frozen_string_literal: true

RSpec.describe RecipeScrapers::Parsers::Durations do
  it "reads an iso 8601 duration" do
    expect(described_class.minutes("PT1H20M")).to eq(80)
  end

  it "reads days in an iso 8601 duration" do
    expect(described_class.minutes("P1DT2H")).to eq(1560)
  end

  it "reads hours and minutes written out" do
    expect(described_class.minutes("1 hr 20 mins")).to eq(80)
  end

  it "reads a bare count of minutes" do
    expect(described_class.minutes("45 minutes")).to eq(45)
  end

  it "reads a german duration" do
    expect(described_class.minutes("1 Std. 30 Min.")).to eq(90)
  end

  it "reads a french duration" do
    expect(described_class.minutes("1 heure 30 minutes")).to eq(90)
  end

  it "reads an italian duration" do
    expect(described_class.minutes("1 ora 30 minuti")).to eq(90)
  end

  it "reads a dutch duration" do
    expect(described_class.minutes("1 uur 30 minuten")).to eq(90)
  end

  it "reads a swedish duration" do
    expect(described_class.minutes("1 tim 30 min")).to eq(90)
  end

  it "reads a norwegian duration" do
    expect(described_class.minutes("1 time 30 minutter")).to eq(90)
  end

  it "reads a hungarian duration" do
    expect(described_class.minutes("1 óra 30 perc")).to eq(90)
  end

  it "reads a russian duration" do
    expect(described_class.minutes("1 ч 30 мин")).to eq(90)
  end

  it "ignores a trailing count of seconds" do
    expect(described_class.minutes("1 hour 30 minutes 20 seconds")).to eq(90)
  end

  it "reads an iso 8601 duration given only in seconds" do
    expect(described_class.minutes("PT3000S")).to eq(50)
  end

  it "reads the value of a Duration object" do
    expect(described_class.minutes({ "@type" => "Duration", "@value" => "P0DT0H35M0S" })).to eq(35)
  end

  it "takes the lower end of a range" do
    expect(described_class.minutes("20-25 minutes")).to eq(20)
  end

  it "passes an integer through" do
    expect(described_class.minutes(30)).to eq(30)
  end

  it "returns nil when there is nothing to read" do
    expect(described_class.minutes("a while")).to be_nil
  end

  it "refuses a duration whose leading number belongs to no unit it knows" do
    expect(described_class.minutes("1 stunde 30 minutos")).to be_nil
  end

  it "refuses a mixed fraction rather than reading the denominator as the hours" do
    expect(described_class.minutes("1 1/4 hours")).to be_nil
  end

  it "refuses a broken iso duration rather than reading a number out of it" do
    expect(described_class.minutes("PT-476070H19M32S")).to be_nil
  end
end
