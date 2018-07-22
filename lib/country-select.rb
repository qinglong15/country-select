# encoding: UTF-8
# CountrySelect
module ActionView
  module Helpers
    module FormOptionsHelper
      # Return select and option tags for the given object and method, using country_options_for_select to generate the list of option tags.
      def country_select(object, method, priority_countries = nil, options = {}, html_options = {})
        if Rails.version.starts_with?("3")
          InstanceTag.new(object, method, self, options.delete(:object)).to_country_select_tag(priority_countries, options, html_options)
        else
          Tags::CountrySelect.new(object, method, self, options).to_country_select_tag(priority_countries, options, html_options)
        end
      end
      # Returns a string of option tags for pretty much any country in the world. Supply a country name as +selected+ to
      # have it marked as the selected option tag. You can also supply an array of countries as +priority_countries+, so
      # that they will be listed above the rest of the (long) list.
      #
      # NOTE: Only the option tags are returned, you have to wrap this call in a regular HTML select tag.
      def country_options_for_select(selected = nil, priority_countries = nil, display = nil)
        country_options = ""

        if display == "ioc"
          countries = IOC_COUNTRIES
        else
          countries = COUNTRIES
        end

        if priority_countries
          if (unlisted = priority_countries - countries).any?
            raise RuntimeError.new("Supplied priority countries are not in the main list: #{unlisted}")
          end
          country_options += options_for_select(priority_countries, selected)
          country_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"

          # prevents selected from being included twice in the HTML which causes
          # some browsers to select the second selected option (not priority)
          # which makes it harder to select an alternative priority country
          selected = nil if priority_countries.include?(selected)
        end

        country_options = country_options.html_safe if country_options.respond_to?(:html_safe)

        return country_options + options_for_select(countries, selected)
      end

      # All the countries included in the country_options output.
      COUNTRIES = [
        "Afghanistan",
        "Åland Islands",
        "Albania",
        "Algeria",
        "American Samoa",
        "Andorra",
        "Angola",
        "Anguilla",
        "Antarctica",
        "Antigua and Barbuda",
        "Argentina",
        "Armenia",
        "Aruba",
        "Australia",
        "Austria",
        "Azerbaijan",
        "Bahamas",
        "Bahrain",
        "Bangladesh",
        "Barbados",
        "Belarus",
        "Belgium",
        "Belize",
        "Benin",
        "Bermuda",
        "Bhutan",
        "Bolivia",
        "Bonaire, Sint Eustatius and Saba",
        "Bosnia and Herzegovina",
        "Botswana",
        "Bouvet Island",
        "Brazil",
        "British Indian Ocean Territory",
        "Brunei Darussalam",
        "Bulgaria",
        "Burkina Faso",
        "Burundi",
        "Cambodia",
        "Cameroon",
        "Canada",
        "Cape Verde",
        "Cayman Islands",
        "Central African Republic",
        "Chad",
        "Chile",
        "China",
        "Christmas Island",
        "Cocos (Keeling) Islands",
        "Colombia",
        "Comoros",
        "Congo",
        "Congo, The Democratic Republic of the",
        "Cook Islands",
        "Costa Rica",
        "Côte d'Ivoire",
        "Croatia",
        "Cuba",
        "Curaçao",
        "Cyprus",
        "Czech Republic",
        "Denmark",
        "Djibouti",
        "Dominica",
        "Dominican Republic",
        "Ecuador",
        "Egypt",
        "El Salvador",
        "Equatorial Guinea",
        "Eritrea",
        "Estonia",
        "Ethiopia",
        "Falkland Islands (Malvinas)",
        "Faroe Islands",
        "Fiji",
        "Finland",
        "France",
        "French Guiana",
        "French Polynesia",
        "French Southern Territories",
        "Gabon",
        "Gambia",
        "Georgia",
        "Germany",
        "Ghana",
        "Gibraltar",
        "Greece",
        "Greenland",
        "Grenada",
        "Guadeloupe",
        "Guam",
        "Guatemala",
        "Guernsey",
        "Guinea",
        "Guinea-Bissau",
        "Guyana",
        "Haiti",
        "Heard Island and McDonald Islands",
        "Holy See (Vatican City State)",
        "Honduras",
        "Hong Kong",
        "Hungary",
        "Iceland",
        "India",
        "Indonesia",
        "Iran, Islamic Republic of",
        "Iraq",
        "Ireland",
        "Isle of Man",
        "Israel",
        "Italy",
        "Jamaica",
        "Japan",
        "Jersey",
        "Jordan",
        "Kazakhstan",
        "Kenya",
        "Kiribati",
        "Korea, Democratic People's Republic of",
        "Korea, Republic of",
        "Kuwait",
        "Kyrgyzstan",
        "Lao People's Democratic Republic",
        "Latvia",
        "Lebanon",
        "Lesotho",
        "Liberia",
        "Libya",
        "Liechtenstein",
        "Lithuania",
        "Luxembourg",
        "Macao",
        "Macedonia, Republic Of",
        "Madagascar",
        "Malawi",
        "Malaysia",
        "Maldives",
        "Mali",
        "Malta",
        "Marshall Islands",
        "Martinique",
        "Mauritania",
        "Mauritius",
        "Mayotte",
        "Mexico",
        "Micronesia, Federated States of",
        "Moldova, Republic of",
        "Monaco",
        "Mongolia",
        "Montenegro",
        "Montserrat",
        "Morocco",
        "Mozambique",
        "Myanmar",
        "Namibia",
        "Nauru",
        "Nepal",
        "Netherlands",
        "New Caledonia",
        "New Zealand",
        "Nicaragua",
        "Niger",
        "Nigeria",
        "Niue",
        "Norfolk Island",
        "Northern Mariana Islands",
        "Norway",
        "Oman",
        "Pakistan",
        "Palau",
        "Palestine, State of",
        "Panama",
        "Papua New Guinea",
        "Paraguay",
        "Peru",
        "Philippines",
        "Pitcairn",
        "Poland",
        "Portugal",
        "Puerto Rico",
        "Qatar",
        "Reunion",
        "Romania",
        "Russian Federation",
        "Rwanda",
        "Saint Barthélemy",
        "Saint Helena, Ascension and Tristan da Cunha",
        "Saint Kitts and Nevis",
        "Saint Lucia",
        "Saint Martin (French Part)",
        "Saint Pierre and Miquelon",
        "Saint Vincent and the Grenadines",
        "Samoa",
        "San Marino",
        "Sao Tome and Principe",
        "Saudi Arabia",
        "Senegal",
        "Serbia",
        "Seychelles",
        "Sierra Leone",
        "Singapore",
        "Sint Maarten (Dutch Part)",
        "Slovakia",
        "Slovenia",
        "Solomon Islands",
        "Somalia",
        "South Africa",
        "South Georgia and the South Sandwich Islands",
        "South Sudan",
        "Spain",
        "Sri Lanka",
        "Sudan",
        "Suriname",
        "Svalbard and Jan Mayen",
        "Swaziland",
        "Sweden",
        "Switzerland",
        "Syrian Arab Republic",
        "Taiwan",
        "Tajikistan",
        "Tanzania, United Republic of",
        "Thailand",
        "Timor-Leste",
        "Togo",
        "Tokelau",
        "Tonga",
        "Trinidad and Tobago",
        "Tunisia",
        "Turkey",
        "Turkmenistan",
        "Turks and Caicos Islands",
        "Tuvalu",
        "Uganda",
        "Ukraine",
        "United Arab Emirates",
        "United Kingdom",
        "United States",
        "United States Minor Outlying Islands",
        "Uruguay",
        "Uzbekistan",
        "Vanuatu",
        "Venezuela",
        "Viet Nam",
        "Virgin Islands, British",
        "Virgin Islands, U.S.",
        "Wallis and Futuna",
        "Western Sahara",
        "Yemen",
        "Zambia",
        "Zimbabwe"
      ] unless const_defined?("COUNTRIES")

      # All the countries included in the ioc country_options output
      IOC_COUNTRIES = [["Afghanistan", "AFG"], ["Albania", "ALB"], ["Algeria", "ALG"], ["American Samoa", "ASA"], ["Andorra", "AND"], ["Angola", "ANG"],
        ["Antigua And Barbuda", "ANT"], ["Argentina", "ARG"], ["Armenia", "ARM"], ["Aruba", "ARU"], ["Australia", "AUS"], ["Austria", "AUT"], ["Azerbaijan", "AZE"],
        ["Bahamas", "BAH"], ["Bahrain", "BRN"], ["Bangladesh", "BAN"], ["Barbados", "BAR"], ["Belarus", "BLR"], ["Belgium", "BEL"], ["Belize", "BIZ"], ["Benin", "BEN"],
        ["Bermuda", "BER"], ["Bhutan", "BHU"], ["Bolivia, Plurinational State of", "BOL"], ["Bosnia and Herzegovina", "BIH"], ["Botswana", "BOT"], ["Brazil", "BRA"],
        ["Brunei Darussalam", "BRU"], ["Bulgaria", "BUL"], ["Burkina Faso", "BUR"], ["Burundi", "BDI"],
        ["Cambodia", "CAM"], ["Cameroon", "CMR"], ["Canada", "CAN"], ["Cape Verde", "CPV"], ["Cayman Islands", "CAY"], ["Central African Republic", "CAF"], ["Chad", "CHA"], ["Chile", "CHI"], ["China", "CHN"],
        ["Colombia", "COL"], ["Comoros", "COM"], ["Congo", "COD"], ["Congo, the Democratic Republic of the", "CGO"], ["Cook Islands", "COK"], ["Costa Rica", "CRC"],
        ["Cote d'Ivoire", "CIV"], ["Croatia", "CRO"], ["Cuba", "CUB"], ["Cyprus", "CYP"], ["Czech Republic", "CZE"],
        ["Denmark", "DEN"], ["Djibouti", "DJI"], ["Dominica", "DMA"], ["Dominican Republic", "DOM"],
        ["Ecuador", "ECU"], ["Egypt", "EGY"], ["El Salvador", "ESA"], ["Equatorial Guinea", "GEQ"], ["Eritrea", "ERI"], ["Estonia", "EST"], ["Ethiopia", "ETH"],
        ["Faroe Islands", "FRO"], ["Fiji", "FIJ"], ["Finland", "FIN"], ["France", "FRA"],
        ["Gabon", "GAB"], ["Gambia", "GAM"], ["Georgia", "GEO"], ["Germany", "GER"], ["Ghana", "GHA"], ["Greece", "GRE"], ["Grenada", "GRN"],
        ["Guam", "GUM"], ["Guatemala", "GUA"], ["Guinea", "GUI"], ["Guinea-Bissau", "GBS"], ["Guyana", "GUY"],
        ["Haiti", "HAI"], ["Honduras", "HON"], ["Hong Kong", "HKG"], ["Hungary", "HUN"],
        ["Iceland", "ISL"], ["India", "IND"], ["Indonesia", "INA"], ["Iran, Islamic Republic of", "IRI"], ["Iraq", "IRQ"], ["Ireland", "IRL"], ["Israel", "ISR"], ["Italy", "ITA"],
        ["Jamaica", "JAM"], ["Japan", "JPN"], ["Jordan", "JOR"],
        ["Kazakhstan", "KAZ"], ["Kenya", "KEN"], ["Kiribati", "KIR"], ["Korea, Democratic People's Republic of", "PRK"], ["Korea, Republic of", "KOR"], ["Kuwait", "KUW"], ["Kyrgyzstan", "KGZ"],
        ["Lao People's Democratic Republic", "LAO"], ["Latvia", "LAT"], ["Lebanon", "LIB"], ["Lesotho", "LES"], ["Liberia", "LBR"], ["Libya", "LBA"],
        ["Liechtenstein", "LIE"], ["Lithuania", "LTU"], ["Luxembourg", "LUX"], ["Macao", "MAC"],
        ["Macedonia, The Former Yugoslav Republic Of", "MKD"], ["Madagascar", "MAD"], ["Malawi", "MAW"], ["Malaysia", "MAS"], ["Maldives", "MDV"], ["Mali", "MLI"], ["Malta", "MLT"],
        ["Marshall Islands", "MHL"], ["Mauritania", "MTN"], ["Mauritius", "MRI"], ["Mexico", "MEX"], ["Micronesia, Federated States of", "FSM"],
        ["Moldova, Republic of", "MDA"], ["Monaco", "MON"], ["Mongolia", "MGL"], ["Montenegro", "MNE"], ["Morocco", "MAR"], ["Mozambique", "MOZ"], ["Myanmar", "MYA"],
        ["Namibia", "NAM"], ["Nauru", "NRU"], ["Nepal", "NEP"], ["Netherlands", "NED"], ["New Zealand", "NZL"], ["Nicaragua", "NCA"], ["Niger", "NIG"], ["Nigeria", "NGR"], ["Norway", "NOR"],
        ["Oman", "OMA"],
        ["Pakistan", "PAK"], ["Palau", "PLW"], ["Palestinian Territory, Occupied", "PLE"], ["Panama", "PAN"], ["Papua New Guinea", "PNG"], ["Paraguay", "PAR"], ["Peru", "PER"], ["Philippines", "PHI"],
        ["Poland", "POL"], ["Portugal", "POR"], ["Puerto Rico", "PUR"],
        ["Qatar", "QAT"],
        ["Romania", "ROU"], ["Russian Federation", "RUS"], ["Rwanda", "RWA"],
        ["Saint Kitts and Nevis", "SKN"], ["Saint Lucia", "LCA"], ["Saint Vincent and the Grenadines", "VIN"], ["Samoa", "SAM"], ["San Marino", "SMR"], ["Sao Tome and Principe", "STP"],
        ["Saudi Arabia", "KSA"], ["Senegal", "SEN"], ["Serbia", "SRB"], ["Seychelles", "SEY"], ["Sierra Leone", "SLE"], ["Singapore", "SIN"], ["Slovakia", "SVK"], ["Slovenia", "SLO"],
        ["Solomon Islands", "SOL"], ["Somalia", "SOM"], ["South Africa", "RSA"], ["Spain", "ESP"], ["Sri Lanka", "SRI"], ["Sudan", "SUD"], ["Suriname", "SUR"], ["Swaziland", "SWZ"],
        ["Sweden", "SWE"], ["Switzerland", "SUI"], ["Syrian Arab Republic", "SYR"],
        ["Tajikistan", "TJK"], ["Tanzania, United Republic of", "TAN"], ["Thailand", "THA"], ["Timor-Leste", "TLS"], ["Togo", "TOG"], ["Tonga", "TGA"], ["Trinidad and Tobago", "TRI"],
        ["Tunisia", "TUN"], ["Turkey", "TUR"], ["Turkmenistan", "TKM"], ["Tuvalu", "TUV"],
        ["Uganda", "UGA"], ["Ukraine", "UKR"], ["United Arab Emirates", "UAE"], ["United Kingdom", "GBR"], ["United States", "USA"], ["Uruguay", "URU"], ["Uzbekistan", "UZB"],
        ["Vanuatu", "VAN"], ["Venezuela, Bolivarian Republic of", "VEN"], ["Viet Nam", "VIE"], ["Virgin Islands, British", "IVB"], ["Virgin Islands, U.S.", "ISV"],
        ["Yemen", "YEM"],
        ["Zambia", "ZAM"], ["Zimbabwe", "ZIM"]] unless const_defined?("IOC_COUNTRIES")
    end

    module CountrySelectTag
      def to_country_select_tag(priority_countries, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",

          add_options(
            country_options_for_select(value, priority_countries, options[:display]),
            options, value
          ), html_options
        )
      end
    end

    # For Rails 4.x / 5.x
    if Rails.version.to_i >= 4
      module Tags
        class CountrySelect < Base
          include CountrySelectTag
        end
      end
    else
      # For Rails 3.x
      class InstanceTag
        include CountrySelectTag
      end
    end

    class FormBuilder
      def country_select(method, priority_countries = nil, options = {}, html_options = {})
        @template.country_select(@object_name, method, priority_countries, options.merge(:object => @object), html_options)
      end
    end
  end
end
