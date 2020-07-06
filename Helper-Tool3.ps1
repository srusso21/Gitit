$list = "Chris Polaski", 
"Troy Flick", 
"Ryan Kane", 
"Leah Crowe", 
"Micah Dietz", 
"Alan Herrera", 
"Rachel Whitehill", 
"Alexander Chan", 
"Stephen Placido", 
"Maira Vega", 
"Veronica Rodriguez", 
"Cate Waligora", 
"Lindsay Suprenant", 
"Jonathan Zhou", 
"Mohammad Hatahet", 
"Erika Sanchez", 
"Zach Motsinger", 
"Johnny Betzer", 
"Niraj Patel", 
"Tami Green", 
"Genaro Mendoza", 
"Luis Rodriguez", 
"Diana Melendez", 
"Chelsea Chamra", 
"Michele Olivo", 
"Delia Farrell", 
"Zach Barton", 
"Efren Murillo", 
"Ben Blakeman", 
"Martin Camacho", 
"Ramon Salcido", 
"Marek Pula", 
"Andrew Lee", 
"Erik Randa", 
"Rob Kiester", 
"Kevin Strohfus", 
"Isaac Sawatzky", 
"Sara Ruiz", 
"Kelsey Grundman", 
"Ryan Bullock", 
"Vassanti Bribiesca", 
"Patricia Valero", 
"Saatchi Kishnani", 
"Callie Bergin"

$a = Get-ADComputer -Filter * -Properties description




foreach ($user in $list){
    
    $a | Where-Object {($_.description -eq $SplitName[0]) -and ($_.description -eq $splitName[1])} | select name,description
}
