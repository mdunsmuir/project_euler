data Sheet = A1 | A2 | A3 | A4 | A5 deriving (Enum, Show)

cut :: Sheet -> Sheet
cut = succ

cutProducts A5 = []
cutProducts sheet = let next = cut sheet
                    in  next : cutProducts next

batches initial = do
  let nSheets = length initial
  sheet <- initial
  let ps = cutProducts sheet
  
