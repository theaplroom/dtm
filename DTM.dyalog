:Namespace DTM
⍝ == Dictionaries, Tables and Maps
⍝ Emulates the @ function from the K language _
⍝ and extends to some useful functions for handling these datatypes
⍝
⍝ Dictionaries and maps are 2-element vectors of keys and values. _
⍝ Both elements are vectors of the same length. _
⍝ The keys are character vectors. No duplicates allowed.
⍝
⍝ Tables are matrices with 1 or more rows. _
⍝ The top row contains the keys. Each key is a character vector.
⍝
⍝ === Type and properties
⍝ ""TYPECHECKING"": scalar flag, _
⍝ determines whether dictionary and table functions check their argument datatypes. _
⍝ Defaults to 1.
⍝
⍝ ""isD"": is ""⍵"" a dictionary?
⍝ ""isT"": is ""⍵"" a table?
⍝ ""keysIn"": list of keys in dictionary or table ""⍵""
⍝ ""rowsIn"": number of data rows in table ""⍵""
⍝ ""valsIn"": values of dictionary or table ""⍵""; _
⍝ respectively a vector or matrix
⍝
⍝ === at
⍝ Values from dictionary or table ""⍺"" for keys ""⍵"". _
⍝ For a table, the values are one or more columns. _
⍝ For a dictionary, the values are one or more elements. _
⍝ The keys may be one or more character vectors. _
⍝ For a single character vector key, the value is disclosed. Thus: 
⍝ <pre>
⍝       ModelDictionary at 'cow'
⍝ vache
⍝       ModelDictionary at 'dog' 'cow'
⍝ ┌─────┬─────┐
⍝ │chien│vache│
⍝ └─────┴─────┘
⍝       ModelTable at 'English'
⍝ ┌───┬─────┬───┬───┐
⍝ │cow│sheep│cat│dog│
⍝ └───┴─────┴───┴───┘
⍝       ModelTable at 'French' English'
⍝ ┌─────────────────────────┬───────────────────┐
⍝ │┌─────┬──────┬────┬─────┐│┌───┬─────┬───┬───┐│
⍝ ││vache│mouton│chat│chien│││cow│sheep│cat│dog││
⍝ │└─────┴──────┴────┴─────┘│└───┴─────┴───┴───┘│
⍝ └─────────────────────────┴───────────────────┘  
⍝ </pre>
⍝
⍝ === select
⍝ a new table or dictionary, containing only the keys ""⍵""
⍝
⍝ === for
⍝ A new table, containing only rows selected by ""⍵"". _
⍝ ""⍵"" is either:
⍝ * a vector of flags, of length ""rowsIn ⍺""
⍝ * a key followed by a list of values to match
⍝ Examples:
⍝ <pre> ModelTable for 'c'=⊃¨ModelTable at 'English'
⍝ ┌───────┬──────┬──────┐
⍝ │English│French│German│
⍝ ├───────┼──────┼──────┤
⍝ │cow    │vache │Kuh   │
⍝ ├───────┼──────┼──────┤
⍝ │cat    │chat  │Katze │
⍝ └───────┴──────┴──────┘
⍝
⍝ ModelTable for 'French' 'mouton' 'vache'
⍝ ┌───────┬──────┬──────┐
⍝ │English│French│German│
⍝ ├───────┼──────┼──────┤
⍝ │cow    │vache │Kuh   │
⍝ ├───────┼──────┼──────┤
⍝ │sheep  │mouton│Schaf │
⍝ └───────┴──────┴──────┘
⍝ </pre>
⍝
⍝ === amend
⍝ ""⍺"" with new definitions for key:value pair/s ""⍵"".
⍝ Any keys already defined in ""⍺"" get new values. _
⍝ For table ""⍺"", values are columns of length ""rowsIn ⍺"". _
⍝ Examples:
⍝ <pre>
⍝ q←ModelDictionary amend 'cow' 'boeuf'
⍝ q←ModelDictionary amend ('cow' 'boeuf')('fox' 'renard')
⍝ q←ModelTable amend 'French' ('boeuf' 'mouton' 'chat' 'chien')
⍝ q←⊂'French' ('boeuf' 'mouton' 'chat' 'chien')
⍝ q,←⊂'Danish' ('ko' 'far' 'katte' 'hund')
⍝ q←ModelTable amend q
⍝ </pre>
⍝
⍝ === sortedBy
⍝ Table ""⍺"" with rows sorted by columns for key/s ""⍵""
⍝ ""COLLATION"": collating order for alphabetical sort
⍝ Examples:
⍝ <pre>
⍝ ModelTable sortedBy 'English' 'French'
⍝ ┌───────┬──────┬──────┐
⍝ │English│French│German│
⍝ ├───────┼──────┼──────┤
⍝ │cat    │chat  │Katze │
⍝ ├───────┼──────┼──────┤
⍝ │cow    │vache │Kuh   │
⍝ ├───────┼──────┼──────┤
⍝ │dog    │chien │Hund  │
⍝ ├───────┼──────┼──────┤
⍝ │sheep  │mouton│Schaf │
⍝ └───────┴──────┴──────┘
⍝ </pre>  
⍝
⍝ === groupedBy
⍝ A list of tables corresponding to unique values in column ""⍵"". _
⍝ Each table has the same keys as ""⍺"".


    (⎕IO ⎕ML ⎕WX)←1 1 3
    ∇ Z←Version
      :Access Public shared
      Z←(⍕⎕THIS)'1.0.0' '2015-02-01'
    ∇

    ⍝ model arrays for test functions

    ∇ Z←ModelDictionary
    ⍝ model dictionary for automated tests
      Z←('cow' 'sheep' 'cat' 'dog')('vache' 'mouton' 'chat' 'chien')
    ∇
    ∇ Z←ModelTable;∆
    ⍝ model table for automated tests
      ∆←⊂'cow' 'sheep' 'cat' 'dog'
      ∆,←⊂'vache' 'mouton' 'chat' 'chien'
      ∆,←⊂'Kuh' 'Schaf' 'Katze' 'Hund'
      Z←⍉'English' 'French' 'German',↑∆
    ∇

    TYPECHECKING←1 ⍝ global toggle for detailed type chacking

      isD←{
      ⍝ is ⍵ a dictionary?
          ~TYPECHECKING:1=≢⍴⍵
          1≠⊃⍴⍴⍵:0              ⍝  is vector
          2≠≢⍵:0                ⍝  with 2 elements
          ≠/≢¨⍵:0               ⍝  of same length
          areKeys⊃⍵
      }

      isT←{
      ⍝ is ⍵ a table?
          ~TYPECHECKING:2=≢⍴⍵
          2≠⊃⍴⍴⍵:0              ⍝  is matrix
          0=≢⍵:0                ⍝  with 1+ rows
          areKeys ⍵[⎕IO;]
      }
      areKeys←{
      ⍝ is ⍵ a valid set of keys?
          1∨.≠⊃¨⍴¨⍴¨⍵:0         ⍝ vectors
          ' '∨.≠⊃¨0⍴¨⍵:0        ⍝ character
          ⍵≡∪⍵                  ⍝ unique
      }

      keysIn←{
      ⍝ keys of dictionary or table ⍵
          isD ⍵:⎕IO⊃⍵
          isT ⍵:⍵[⎕IO;]
          ⎕SIGNAL 11
      }
      valsIn←{
      ⍝ values of dictionary or table ⍵
          isD ⍵:(⎕IO+1)⊃⍵
          isT ⍵:1 0↓⍵
          ⎕SIGNAL 11
      }
      rowsIn←{
       ⍝ number of rows in table ⍵
          isT ⍵:1-⍨≢⍵
          ⎕SIGNAL 11
      }

      at←{
      ⍝ value/s of dictionary or table ⍺ for key/s ⍵
          0::⎕SIGNAL ⎕EN
          v←valsIn ⍺
          i←(keysIn ⍺)⍳eis ⍵
          isD ⍺:⍵ dis(v,⎕NULL)[i]
          isT ⍺:⍵ dis↓[⎕IO]v[;,i]
      }

      select←{
       ⍝ dictionary or table ⍺ with keys ⍵
          k←,eis ⍵
          isD ⍺:(k)(⍺ at k)
          0::⎕SIGNAL ⎕EN
          isT ⍺:k⍪(valsIn ⍺)[;k⍳⍨keysIn ⍺]
      }

      for←{
       ⍝ rows of table ⍺ selected by ⍺
       ⍝ ⍺: either: flag for each row in valsIn ⍺
       ⍝    or:     key followed by one or more values to match
          ~isT ⍺:⎕SIGNAL 11
          1≠⊃⍴⍴⍵:⎕SIGNAL 4
          k←keysIn ⍺
          ((≢⍵)=rowsIn ⍺)∧∧/(∪⍵)∊0 1:k⍪⍵⌿valsIn ⍺
          (⎕IO⌷⍵)∊k:k⍪((⍺ at⊃⍵)∊1↓⍵)⌿valsIn ⍺
          ⎕SIGNAL 11
      }

      amend←{
        ⍝ set/replace key/value pair/s in dictionary ⍺
        ⍝ or key/column pair/s in table ⍺
          1=≡⍵:⎕SIGNAL 11
          1≠⊃⍴⍴⍵:⎕SIGNAL 4
          0::⎕SIGNAL ⎕EN
          nk nv←{
              (2=≢⍵)∧1=≡⊃⍵:,∘⊂¨⍵    ⍝ key val
              2∧.=≢¨⍵:↓⍉↑⍵          ⍝ (key val)(key val)
              ⎕SIGNAL 11
          }⍵
          keep←~nk∊⍨keysIn ⍺
          isD ⍺:(keep∘/¨⍺),¨nk nv
          isT ⍺:(keep/⍺),nk⍪⍉↑nv
          ⎕SIGNAL 11
      }

    COLLATION←⎕D,⍨,⎕UCS (⎕UCS 'Aa')∘.+(⍳26)-⎕IO ⍝ collating sequence for alpha sorting

      sortedBy←{
     ⍝ table ⍺ with rows sorted alphabetically by values of column/s ⍵
          ~isT ⍺:⎕SIGNAL 11
          k←,eis ⍵
          0∊k∊keysIn ⍺:⎕SIGNAL 3
          ⍺[⎕IO,⎕IO+COLLATION⍋↑,/valsIn ⍺ select k;]
      }

      groupedBy←{
      ⍝ list of tables each with same value in column/s ⍵
          ⍺∘for¨⍵∘{⍺ ⍵}¨∪⍺ at ⍵     ⍝ FIXME efficiency
      }


:EndNamespace