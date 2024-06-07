party_colors <- c(
  "KW.BEZPARTYJNI.SAMORZĄDOWCY" = "#FF5733",         # Example color
  "KKW.TRZECIA.DROGA.PSL.PL2050.SZYMONA.HOŁOWNI" = "#33FF57",  # Example color
  "KW.NOWA.LEWICA" = "#3357FF",                      # Example color
  "KW.PRAWO.I.SPRAWIEDLIWOŚĆ" = "#e60d41",           # Example color
  "KW.KONFEDERACJA.WOLNOŚĆ.I.NIEPODLEGŁOŚĆ" = "#FF8C33", # Example color
  "KKW.KOALICJA.OBYWATELSKA.PO..N.IPL.ZIELONI" = "#fba754", # Example color
  "KW.POLSKA.JEST.JEDNA" = "#33FFB8",                # Example color
  "KWW.RDIP" = "#FF3333",                            # Example color
  "KW.ANTYPARTIA" = "#33D1FF",                       # Example color
  "KW.NORMALNY.KRAJ" = "#FF33D1",                    # Example color
  "KW.RUCH.NAPRAWY.POLSKI" = "#B8FF33",              # Example color
  "KWW.MNIEJSZOŚĆ.NIEMIECKA" = "#FF5733"             # Example color
)

logo_mapping <- data.frame(
  party = c("KW.BEZPARTYJNI.SAMORZĄDOWCY", "KKW.TRZECIA.DROGA.PSL.PL2050.SZYMONA.HOŁOWNI", 
            "KW.NOWA.LEWICA", "KW.PRAWO.I.SPRAWIEDLIWOŚĆ", "KW.KONFEDERACJA.WOLNOŚĆ.I.NIEPODLEGŁOŚĆ",             "KKW.KOALICJA.OBYWATELSKA.PO..N.IPL.ZIELONI", "KW.POLSKA.JEST.JEDNA", "KWW.RDIP", 
            "KW.ANTYPARTIA", "KW.NORMALNY.KRAJ", "KW.RUCH.NAPRAWY.POLSKI", "KWW.MNIEJSZOŚĆ.NIEMIECKA"),
  logo = c("logos/bezpartyjni.png", "logos/pl2050.png", "logos/lewica.png", "logos/PiS.png",
           "logos/Konfederacja.png", "logos/KO.png", "logos/pjj.png", "logos/rdip.png",
           "logos/antypartia.png", "logos/normalnykraj.png", "logos/rnp.png", "logos/mniejszosc_niemicka.png")
)
