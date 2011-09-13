module IBANTools
  module BIC
    def bic
      if country_bics_mapped? self.country_code
        bic_map = bic_maps[self.country_code]
        return find_bic bic_map, self.code
      else
        return nil
      end
    end

    def bic_maps
      {"FI" => {
        "1" =>  "NDEAFIHH",
        "2" =>  "NDEAFIHH",
        "31" => "HANDFIHH",
        "33" => "ESSEFIHX",
        "34" => "DABAFIHX",
        "36" => "TAPIFI22",
        "37" => "DNBAFIHX",
        "38" => "SWEDFIHH",
        "39" => "SBANFIHH",
        "4" =>  "HELSFIHH",
        "5" =>  "OKOYFIHH",
        "6" =>  "AABAFI22",
        "8" =>  "DABAFIHH"
      }}
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
