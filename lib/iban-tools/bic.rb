module IBANTools
  module BIC
    def bic
      if country_bics_mapped?(self.country_code) and IBAN.valid?(self.code)
        bic_map = bic_maps[self.country_code]
        return find_bic bic_map, self.code
      else
        return nil
      end
    end

    def bic_maps
      {'FI' =>
           {
               '405' => 'HELSFIHH', # Aktia
               '497' => 'HELSFIHH', # Aktia
               '717' => 'BIGKFIH1', # Bigbank
               '47' => 'POPFFI22', # POP
               '713' => 'CITIFIHX', # Citibank
               '34' => 'DABAFIHX', # Danske Bank A/S, Suomen sivuliike
               '8' => 'DABAFIHH', # Danske Bank A/S, Suomen sivuliike
               '37' => 'DNBAFIHX', # DNB Bank ASA, Finland Branch
               '31' => 'HANDFIHH', # Handelsbanken
               '799' => 'HOLVFIHH', # Holvi
               '1' => 'NDEAFIHH', # Nordea
               '2' => 'NDEAFIHH', # Nordea
               '5' => 'OKOYFIHH', # OP Ryhmä
               '33' => 'ESSEFIHX', # SEB
               '36' => 'SBANFIHH', # S-Pankki
               '39' => 'SBANFIHH', # S-Pankki
               '38' => 'SWEDFIHH', # Swedbank
               '798' => 'VPAYFIH2', # Viva Payment Services S.A., Suomen sivuliike
               '6' => 'AABAFI22' # Ålandsbanken
           }
      }
    end

    def country_bics_mapped? country_code
      bic_maps[country_code] != nil
    end

    private

    def find_bic bic_map, iban
      (0..10).each do |i|
        start_index = 4
        s_key = iban[start_index..i+start_index]
        i_key = s_key.to_i
        bic = bic_map[i_key.to_s]
        if bic
          return bic
        end
      end
      raise "Bic mapping problem"
    end
  end
end
