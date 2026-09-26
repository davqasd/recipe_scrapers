# frozen_string_literal: true

module RecipeScrapers
  # The ancestor of every error the gem raises.
  class Error < StandardError; end
  # Raised when the gem does not support the host and supported_only is on.
  class UnsupportedSite < Error; end
  # Raised when a page has no recipe title or no ingredients.
  class RecipeNotFound < Error; end
  # Raised when a response body is larger than {Configuration#max_body_bytes}.
  class ResponseTooLarge < Error; end
  # Raised when a host resolves to no address, or to a private, loopback or other non-public one.
  class BlockedAddress < Error; end
  # Raised when a redirect chain is longer than {Configuration#max_redirects}.
  class TooManyRedirects < Error; end
end
