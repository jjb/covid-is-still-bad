require 'ruby-graphviz'
require 'erb'

g = GraphViz.new( :G, :type => 'digraph' )
g.node[shape: 'circle', style: 'filled', fontname: 'garamond', fillcolor: 'white',
  fontsize:'20px', penwidth: '3px', fixedsize: true, width: 2.3, height: 2.3]

g[:truecolor => true, :bgcolor => "transparent"]

is_there_pandemic = g.add_node("Is there a\npandemic\nhappening\nright now?")
no_pandemic = g.add_node('no_pandemic', label: "No")
why_no_pandemic = g.add_node('why_no_pandemic', label: "Why?")
virus_milder = g.add_node("The virus\ngot milder")
why_milder = g.add_node("How did it\nget milder?")
all_v_get_milder = g.add_node("Don't all viruses\nget milder?")
dunno_milder = g.add_node('dunno_milder', label: "I dunno")
dunno_illness = g.add_node('dunno_illness', label: "I dunno")
hybrid = g.add_node("Vaccines and\nhybrid immunity")
why_still_illness = g.add_node("Why is there\nstill so much\nillness?")
no_illness = g.add_node("What illness?")
lockdowns = g.add_node("Lockdowns")
hoax = g.add_node("Covid was never\nbad, it was always\na hoax.")

yes_pandemic = g.add_node('yes_pandemic', label: "Yes")
wear_mask = g.add_node("Do you\nwear a mask?")
yes_mask = g.add_node('yes_mask', label: "Yes")
no_mask = g.add_node('no_mask', label: "No")
why_no_mask = g.add_node('why_no_mask', label: "Why")
peer_pressure = g.add_node("Peer pressure")
masks_no_work = g.add_node("Masks don't work")
why_masks_no_work = g.add_node('why_masks_no_work', label: "Why")
holes_too_big = g.add_node("The holes are\ntoo big for\nthe little virus.")
people_no_wear_properly = g.add_node("People don't\nwear them properly")

g.add_edge(is_there_pandemic, no_pandemic)
g.add_edge(is_there_pandemic, yes_pandemic)
g.add_edge(no_pandemic, why_no_pandemic)
g.add_edge(why_no_pandemic, virus_milder)
g.add_edge(why_no_pandemic, hoax)
g.add_edge(virus_milder, why_milder)
g.add_edge(why_milder, all_v_get_milder)
g.add_edge(why_milder, dunno_milder)
g.add_edge(why_milder, hybrid)
g.add_edge(hybrid, why_still_illness)
g.add_edge(why_still_illness, dunno_illness)
g.add_edge(why_still_illness, no_illness)
g.add_edge(why_still_illness, lockdowns)
g.add_edge(yes_pandemic, wear_mask)
g.add_edge(wear_mask, no_mask)
g.add_edge(wear_mask, yes_mask)
g.add_edge(no_mask, why_no_mask)
g.add_edge(why_no_mask, peer_pressure)
g.add_edge(why_no_mask, masks_no_work)
g.add_edge(masks_no_work, why_masks_no_work)
g.add_edge(why_masks_no_work, holes_too_big)
g.add_edge(why_masks_no_work, people_no_wear_properly)

[
  v_not_get_milder = g.add_node("No, viruses don't\nalways get milder", URL: 'https://www.google.com/search?q=do+all+viruses+get+milder', target: 'new'),
  covid_is_not_milder = g.add_node("Covid is not milder", URL: 'https://youhavetoliveyour.life/covid-is-mild-now', target: 'new'),
  masks_do_work = g.add_node("Masks are very\neffective even if\nnot worn perfectly.", URL: 'https://youhavetoliveyour.life/masks-dont-work', target: 'new'),
  resist_peer_pressure = g.add_node("Doing what's right\n& leading by example\nbenefits everyone", URL: 'https://www.google.com/search?q=how+to+resist+peer+pressure+to+do+what%27s+right+for+yourself+and+your+community%2C+and+be+an+example+for+others&sca_esv=651549d4eb9f225e&sxsrf=ADLYWIIdexGLUw6hhWxFPgGem6_TAQYTlA%3A1731884662241&ei=dnY6Z-23DrTbptQP2srWsA0&ved=0ahUKEwjtytaQveSJAxW0rYkEHVqlFdYQ4dUDCA8&uact=5&oq=how+to+resist+peer+pressure+to+do+what%27s+right+for+yourself+and+your+community%2C+and+be+an+example+for+others', target: 'new'),
  build_immunity = g.add_node("It's a myth that\nexposure to pathogens \nis needed for a \nhealthy immune system", URL: 'https://youhavetoliveyour.life/we-need-exposure-for-immunity', target: 'new'),
  weakens_immunse_system = g.add_node("Covid weakens the\nimmune system and\nrepeat infections \nmake it worse", URL: 'https://www.google.com/search?q=covid+weaking+immune+system', target: 'new'),
  increasing_illness = g.add_node("Covid waves continue\nto happen & many\ntypes of illness\nare increasing\nthe last few years", URL: 'https://www.google.com/search?q=increasing+rates+of+illness', target: 'new'),
  not_a_hoax = g.add_node("It's not\na hoax!", URL: 'https://www.google.com/search?q=is+covid+a+hoax', target: 'new'),
  thank_you = g.add_node("Thank you!\n💯🍪")
].each{|g| g[color: 'gold', shape: 'square']}

g.add_edge(all_v_get_milder, v_not_get_milder)
g.add_edge(holes_too_big, masks_do_work)
g.add_edge(people_no_wear_properly, masks_do_work)
g.add_edge(peer_pressure, resist_peer_pressure)
g.add_edge(lockdowns, build_immunity)
g.add_edge(dunno_illness, weakens_immunse_system)
g.add_edge(dunno_milder, covid_is_not_milder)
g.add_edge(no_illness, increasing_illness)
g.add_edge(yes_mask, thank_you)
g.add_edge(hoax, not_a_hoax)

g.output(:png => "graph.png")
g.output(:svg => "graph.svg")

`erb index.html.erb > index.html`
