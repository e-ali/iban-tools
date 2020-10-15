module IBANTools
  module BIC

    BIC_MAP = {
      'FI' => {
        :HELSFIHH => [405, 497], # Aktia
        :BIGKFIH1 => [717], # Bigbank
        :POPFFI22 => [(470..479).to_a].flatten, # POP
        :CITIFIHX => [713], # Citibank
        :DABAFIHH => [8, 34], # Danske Bank A/S, Suomen sivuliike
        :DNBAFIHX => [37], # DNB Bank ASA, Finland Branch
        :HANDFIHH => [31], # Handelsbanken
        :HOLVFIHH => [799], # Holvi
        :NDEAFIHH => [1, 2], # Nordea
        :OKOYFIHH => [5], # OP Ryhmä
        :ESSEFIHX => [33], # SEB
        :SBANFIHH => [36, 39], # S-Pankki
        :SWEDFIHH => [38], # Swedbank
        :VPAYFIH2 => [798], # Viva Payment Services S.A., Suomen sivuliike
        :AABAFI22 => [6], # Ålandsbanken
        :ITELFIHH => [715, 400, 402, 403, (406..408).to_a,
                      (410..412).to_a, (414..421).to_a,
                      (423..432).to_a, (435..452).to_a,
                      (454..464).to_a, (483..493).to_a,
                      (495..496).to_a].flatten # Säästöpankkien Keskuspankki, Säästöpankit (Sp) ja Oma Säästöpankki
      }
    }

    def bic
      if IBAN.valid?(self.code) && BIC_MAP[self.country_code].present?
        find_bic(BIC_MAP[self.country_code], self.code)
      else
        nil
      end
    end

    private

    def find_bic(bic_map, iban)
      start_index = 4

      (0..2).each do |i|
        s_key = iban[start_index..i+start_index]
        i_key = s_key.to_i
        bic_map.each do |key, values|
          if values.include?(i_key)
            return key.to_s
          end
        end
      end

      raise "Bic mapping problem"
    end

  end
end
