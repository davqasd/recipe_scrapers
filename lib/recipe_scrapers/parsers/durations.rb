# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    module Durations
      LANGUAGES = {
        english: { hours: %w[h hr hrs hour hours], minutes: %w[m min mins minute minutes],
                   seconds: %w[s sec secs second seconds] },
        german: { hours: %w[std stunde stunden], minutes: %w[minuten],
                  seconds: %w[sek sekunde sekunden] },
        french: { hours: %w[heure heures], minutes: %w[minute minutes], seconds: %w[seconde secondes] },
        italian: { hours: %w[ora ore], minutes: %w[minuto minuti], seconds: %w[secondo secondi] },
        dutch: { hours: %w[uur], minutes: %w[minuut minuten], seconds: %w[seconde seconden] },
        swedish: { hours: %w[tim timme timmar], minutes: %w[minut minuter],
                   seconds: %w[sekund sekunder] },
        norwegian: { hours: %w[time timer], minutes: %w[minutt minutter], seconds: %w[sekund sekunder] },
        hungarian: { hours: %w[óra órát], minutes: %w[perc percet], seconds: %w[másodperc] },
        russian: { hours: %w[ч час часа часов], minutes: %w[м мин минута минуты минут минуту],
                   seconds: %w[с сек секунда секунды секунд] }
      }.freeze

      HOURS, MINUTES, SECONDS = %i[hours minutes seconds].map do |unit|
        words = LANGUAGES.values.flat_map { |language| language.fetch(unit) }.uniq
        /(\d+)\s*(?:#{words.sort_by { |word| -word.length }.join("|")})\b/i
      end

      ISO = /\AP(?:(\d+)W)?(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:([\d.]+)S)?)?\z/
      ISO_UNIT_MINUTES = [10_080, 1440, 60, 1, 1 / 60.0].freeze
      NUMBER = /\d+/
      RANGE = /(\d+)\s*(?:-|–|—|to|до)\s*\d+/

      class << self
        def minutes(value)
          return nil if value.nil?
          return value if value.is_a?(Integer)
          return minutes(value["@value"]) if value.is_a?(Hash)

          text = Text.normalize(value)
          return nil if text.nil?

          from_iso(text) || from_words(text.gsub(RANGE, '\\1'))
        end

        private

        def from_iso(text)
          match = ISO.match(text)
          return nil unless match&.captures&.any?

          total = match.captures.zip(ISO_UNIT_MINUTES).sum { |count, minutes| count.to_f * minutes }.round
          total.positive? ? total : nil
        end

        def from_words(text)
          hours, mins, secs = [HOURS, MINUTES, SECONDS].map { |unit| text[unit, 1] }
          return sole_number(text) if [hours, mins, secs].compact.empty?
          return nil unless [hours, mins, secs].compact.size == text.scan(NUMBER).size

          total = (hours.to_i * 60) + mins.to_i
          total.positive? ? total : nil
        end

        def sole_number(text)
          numbers = text.scan(NUMBER)
          numbers.size == 1 ? numbers.first.to_i : nil
        end
      end
    end
  end
end
