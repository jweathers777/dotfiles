syn cluster tikzZoneGroup   contains=texComment,texDelimiter,texLength,texMathDelim,texMathMatcher,texMathSymbol,texMathText,texRefZone,texSpecialChar,texStatement,texTypeSize,texTypeStyle
syn region tikzPicture start="\\begin\s*{\s*tikzpicture\s*}" end="\\end\s*{\s*tikzpicture\s*}" keepend contains=@tikzZoneGroup
