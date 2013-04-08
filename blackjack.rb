def calctotal (hand)
  total = 0
  totalalt = 0
  hand.each do |card|
    if card == "J" or card == "Q" or card == "K"
      total = total + 10
      totalalt = totalalt + 10
    elsif card == "A"
      total = total + 1
      totalalt = totalalt + 11
    else
      total = total + card
      totalalt = totalalt + card
    end
  end
  return total, totalalt
end

def showhand (hand)
  hand.each {|card| print card, " "}
end

def determinewinner (t, t2, d, d2)
  tscore = 0
  dscore = 0
  if t2 <= 21 and t2 != t
    tscore = 21 - t2
  else
    tscore = 21 - t
  end
  if d2 <= 21 and d2 != d
    dscore = 21 - d2
  else
    dscore = 21 - d
  end
  return tscore, dscore
end

playagain = "Y"
suit = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"]
deck = suit*4

puts "What's your name?"
name = gets.chomp

while playagain == "Y"

  deck = deck.shuffle
  
  player = [] + deck.pop(2)
  dealer = [] + deck.pop(2)
  
  pbusted = false
  dbusted = false
  
  puts "#{name}, here's your starting hand:"
  showhand(player)
  total, totalalt = calctotal(player)
  
  if total != totalalt
    puts "\nYour score is either #{total} or #{totalalt}"
  else
    puts "\nYour score is #{total}"
  end
    
  dtotal, dtotalalt = calctotal(dealer)
  
  puts "What do you want to do?  Type 'Hit' or 'Stay.'"
  action = gets.chomp
  
  while action == "Hit"
    player = player + deck.pop(1)
    puts "#{name}, here's your current hand:"
    showhand(player)
    
    total, totalalt = calctotal(player)
    
    if total != totalalt
      puts "\nYour score is either #{total} or #{totalalt}"
    else
      puts "\nYour score is #{total}"
    end
    
    if total > 21 and totalalt > 21
      puts "You have busted!"
      pbusted = true
      break
    end
    if dtotal < 17 or dtotalalt < 17
      dealer = dealer + deck.pop(1)
      dtotal, dtotalalt = calctotal(dealer)
      if dtotal > 17 and dtotalalt > 17
        daction = "Stay"
      else
        daction = "Hit"
      end
    else
      daction = "Stay"
    end
    
    if dtotal > 21 and dtotalalt > 21
      puts "Dealer has busted!"
      dbusted = true
      break
    end
    
    puts "What do you want to do?  Type 'Hit' or 'Stay.'"
    action = gets.chomp
  end
  
  while daction == "Hit" and pbusted == false and dbusted == false
    dealer = dealer + deck.pop(1)
    dtotal, dtotalalt = calctotal(dealer)
    if dtotal < 17 or dtotalalt < 17
      daction = "Hit"
    else
      daction = "Stay"
    end
    
    if dtotal > 21 and dtotalalt > 21
      puts "Dealer has busted!"
      dbusted = true
      break
    end
  end
  
  tscore, dscore = determinewinner(total, totalalt, dtotal, dtotalalt)
  
  if tscore < 0
    puts "Dealer wins this round."
  elsif dscore < 0 or tscore < dscore
    puts "You win this round!"
  elsif dscore < tscore
    puts "Dealer wins this round."
  else
    puts "You tie!"
  end
  
  puts "Final scores:"
  if total != totalalt
    puts "#{name}: #{total} / #{totalalt}"
  else
    puts "#{name}: #{total}"
  end
  
  if dtotal != dtotalalt
    puts "Dealer: #{dtotal} / #{dtotalalt}"
  else
    puts "Dealer: #{dtotal}"
  end
  
  puts "Play again? (Y/N)"
  playagain = gets.chomp
end