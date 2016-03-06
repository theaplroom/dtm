:Namespace Tests

      Test_amend_001←{
    ⍝ replace dictionary value
          'boeuf' 'mouton'≢'cow' 'sheep'#.DTM.at⍨#.DTM.ModelDictionary #.DTM.amend'cow' 'boeuf'
      }
      Test_amend_002←{
    ⍝ add dictionary value
          'renard' 'mouton'≢'fox' 'sheep'#.DTM.at⍨#.DTM.ModelDictionary #.DTM.amend'fox' 'renard'
      }
      Test_amend_003←{
    ⍝ replace dictionary values
          'boeuf' 'Milou'≢'cow' 'dog'#.DTM.at⍨#.DTM.ModelDictionary #.DTM.amend('cow' 'boeuf')('dog' 'Milou')
      }
      Test_amend_004←{
    ⍝ add/replace dictionary values
          'renard' 'boeuf'≢'fox' 'cow'#.DTM.at⍨#.DTM.ModelDictionary #.DTM.amend('cow' 'boeuf')('fox' 'renard')
      }
      Test_amend_005←{
    ⍝ replace table column
          ∆←('French')('boeuf' 'mouton' 'chat' 'chien')
          'boeuf' 'mouton' 'chat' 'chien'≢'French'#.DTM.at⍨#.DTM.ModelTable #.DTM.amend ∆
      }
      Test_amend_006←{
    ⍝ add table column
          ∆←('Danish')('ko' 'far' 'katte' 'hund')
          'ko' 'far' 'katte' 'hund'≢'Danish'#.DTM.at⍨#.DTM.ModelTable #.DTM.amend ∆
      }
      Test_amend_007←{
    ⍝ replace/add table columns
          ∆←⊂('Danish')('ko' 'far' 'katte' 'hund')
          ∆,←⊂('French')('boeuf' 'mouton' 'chat' 'chien')
          'mouton' 'far'≢,1 0↓'French' 'Danish'#.DTM.select⍨'English' 'sheep'#.DTM.for⍨#.DTM.ModelTable #.DTM.amend ∆
      }

      Test_at_001←{
    ⍝ dictionary value
          'vache'≢#.DTM.ModelDictionary #.DTM.at'cow'
      }
      Test_at_002←{
    ⍝ dictionary values
          'vache' 'chat'≢#.DTM.ModelDictionary #.DTM.at'cow' 'cat'
      }
      Test_at_003←{
    ⍝ dictionary values and false key
          'vache'⎕NULL≢#.DTM.ModelDictionary #.DTM.at'cow' 'fox'
      }
      Test_at_004←{
    ⍝ table column
          'cow' 'sheep' 'cat' 'dog'≢#.DTM.ModelTable #.DTM.at'English'
      }
      Test_at_005←{
    ⍝ table columns
          ∆←⊂'cow' 'sheep' 'cat' 'dog'
          ∆,←⊂'vache' 'mouton' 'chat' 'chien'
          ∆≢#.DTM.ModelTable #.DTM.at'English' 'French'
      }

      Test_dis_001←{
    ⍝ simple
          (⊃∆)≢'xyz'#.DTM.dis ∆←⊂'abc'
      }
      Test_dis_002←{
    ⍝ nested
          ∆≢('wx' 'yz')#.DTM.dis ∆←'abc' 'def'
      }

      Test_eis_001←{
    ⍝ simple
          (⊂∆)≢#.DTM.eis ∆←'abc'
      }
      Test_eis_002←{
    ⍝ nested
          ∆≢#.DTM.eis ∆←'abc' 'def'
      }

      Test_for_001←{
    ⍝ flags
          ∆←1 1 0 1 0⌿#.DTM.ModelTable
          ∆≢#.DTM.ModelTable #.DTM.for 1 0 1 0
      }
      Test_for_002←{
    ⍝ single value
          ∆←1 1 0 0 0⌿#.DTM.ModelTable
          ∆≢#.DTM.ModelTable #.DTM.for'English' 'cow'
      }
      Test_for_003←{
    ⍝ multiple values
          ∆←1 1 0 1 0⌿#.DTM.ModelTable
          ∆≢#.DTM.ModelTable #.DTM.for'English' 'cat' 'cow'
      }

      Test_groupedBy_001←{
    ⍝ table grouped by values in column
          ∆←'animal' 'count'⍪1,⍨10 1⍴'cow' 'sheep' 'cat' 'dog'
          4≠≢∆ #.DTM.groupedBy'animal'
      }

      Test_isD_000←{
    ⍝ dictionary recognised
          1≠#.DTM.(isD ModelDictionary)
      }
      Test_isD_001←{
    ⍝ dictionary cannot be scalar
          0≠#.DTM.isD 0
      }
      Test_isD_002←{
    ⍝ dictionary cannot be matrix
          0≠#.DTM.(isD 1 2⍴ModelDictionary)
      }
      Test_isD_003←{
    ⍝ dictionary has 2 elements
          0≠#.DTM.(isD 3⍴ModelDictionary)
      }
      Test_isD_004←{
    ⍝ key for each value
          0≠#.DTM.(isD 3 4↑¨ModelDictionary)
      }
      Test_isD_005←{
    ⍝ keys are vectors
          0≠#.DTM.(isD('abcd')(2⊃ModelDictionary))
      }
      Test_isD_006←{
    ⍝ keys are character vectors
          0≠#.DTM.(isD(,⍳4)(2⊃ModelDictionary))
      }
      Test_isD_007←{
    ⍝ keys are unique
          0≠#.DTM.(isD('cow' 'sheep' 'cat' 'cow')(2⊃ModelDictionary))
      }


      Test_isT_000←{
    ⍝ table recognised
          1≠#.DTM.isT #.DTM.ModelTable
      }
      Test_isT_001←{
    ⍝ table cannot be scalar
          0≠#.DTM.isT ⍬⍴#.DTM.ModelTable
      }
      Test_isT_002←{
    ⍝ table cannot be vector
          0≠#.DTM.isT,#.DTM.ModelTable
      }
      Test_isT_003←{
    ⍝ table has header row
          0≠#.DTM.isT 0⌿#.DTM.ModelTable
      }
      Test_isT_005←{
    ⍝ table keys are vectors
          0≠#.DTM.isT'abc'⍪1 0↓#.DTM.ModelTable
      }
      Test_isT_006←{
    ⍝ table keys are character vectors
          0≠#.DTM.isT(⍳¨⍳3)⍪1 0↓#.DTM.ModelTable
      }
      Test_isT_007←{
    ⍝ table keys are unique
          0≠#.DTM.isT'English' 'French' 'English'⍪1 0↓#.DTM.ModelTable
      }

      Test_keysIn_001←{
    ⍝ dictionary
          'cow' 'sheep' 'cat' 'dog'≢#.DTM.keysIn #.DTM.ModelDictionary
      }
      Test_keysIn_002←{
    ⍝ table
          'English' 'French' 'German'≢#.DTM.keysIn #.DTM.ModelTable
      }

      Test_rowsIn_001←{
    ⍝ number of rows in table
          (1-⍨≢∆)≠#.DTM.rowsIn ∆←#.DTM.ModelTable
      }

      Test_select_001←{
    ⍝ dictionary value
          ∆←,¨⊂¨'cow' 'vache'
          ∆≢#.DTM.ModelDictionary #.DTM.select'cow'
      }
      Test_select_002←{
    ⍝ dictionary values
          ∆←('cow' 'cat')('vache' 'chat')
          ∆≢#.DTM.ModelDictionary #.DTM.select'cow' 'cat'
      }
      Test_select_003←{
    ⍝ dictionary values and false key
          ∆←('cow' 'fox')('vache'⎕NULL)
          ∆≢#.DTM.ModelDictionary #.DTM.select'cow' 'fox'
      }
      Test_select_004←{
    ⍝ table column
          ∆←,[⎕IO+0.5]'English' 'cow' 'sheep' 'cat' 'dog'
          ∆≢#.DTM.ModelTable #.DTM.select'English'
      }
      Test_select_005←{
    ⍝ table columns in specified order
          ∆←⊂'vache' 'mouton' 'chat' 'chien'
          ∆,←⊂'cow' 'sheep' 'cat' 'dog'
          ∆←'French' 'English'⍪⍉↑∆
          ∆≢#.DTM.ModelTable #.DTM.select'French' 'English'
      }

      Test_sortedBy_001←{
    ⍝ table with rows sorted by column
          ∆←#.DTM.ModelTable
          ∆[1 4 2 5 3;]≢∆ #.DTM.sortedBy'English'
      }
      Test_sortedBy_002←{
    ⍝ table with rows sorted by columns
          ∆←#.DTM.ModelTable
          ∆[1 4 5 3 2;]≢∆ #.DTM.sortedBy'French' 'German'
      }

      Test_valsIn_001←{
    ⍝ dictionary
          ((⎕IO+1)⊃∆)≢#.DTM.valsIn ∆←#.DTM.ModelDictionary
      }
      Test_valsIn_002←{
    ⍝ table
          (1 0↓∆)≢#.DTM.valsIn ∆←#.DTM.ModelTable
      }

:EndNamespace