require "digest/sha2"

module Devise
  # Implements a way of adding different encryptions.
  # The class should implement a self.digest method that taks the following params:
  #   - password
  #   - stretches: the number of times the encryption will be applied
  #   - salt: the password salt as defined by devise
  #   - pepper: Devise config option
  #
  module Encryptors
    # = Sha512
    # Uses the Sha512 hash algorithm to encrypt passwords.
    class Sha512
      
      # Gererates a default password digest based on salt, pepper and the
      # incoming password.
      def self.digest(password, stretches, salt, pepper)
        digest = pepper
        stretches.times { digest = self.secure_digest(salt, digest, password, pepper) }
        digest
      end

      private

        # Generate a Sha512 digest joining args. Generated token is something like
        #   --arg1--arg2--arg3--argN--
        def self.secure_digest(*tokens)
          ::Digest::SHA512.hexdigest('--' << tokens.flatten.join('--') << '--')
        end        
      
    end
  end
end