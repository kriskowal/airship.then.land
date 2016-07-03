 
A rigid-manifold airship sits before you on its keel and a pair of webbèd feet.
The gondola’s brightly painted prow is the head of a mallard drake.
Fixèd wings extend from the flank and tail for stability and control in flight.
A drive shaft runs along the center line between fore and stern propellers,
with an engine and boiler amidships.
In bold letters, the hull is paintèd “{~A|D|M}{$1~1000+1}”.

+ You b[B]oard the airship. {->init}
>

= deck
  On the deck of the airship, the wood shed is forward, the boiler is
  amidships, its engine abaft, and the helm astern.
  The water and gas reservoirs are in the keel and the framèd manifold
  flies over all, supported by flanking masts.
  Various controls, instruments, tanks, and tackle clutter the deck.
  There is little space to spare for crew and cargo.

  = deck.options
  + You e[E]nter the boiler shed.
    ->amidships
  + You w[W]alk to the port rail.
    ->port
  + You w[W]alk to the starboard rail.
    ->starboard
  + You w[W]alk forward.
    ->forward
  + You w[W]alk astern.
    ->stern
  >
  ->deck

= forward
  The water and solarium reservoir instruments and controls are here.
  = forward.options
  The water reservoir depth gauge reads {$reservoir.water} gallons.
  - {!nozzle}
    + You p[P]ull the keel nozzle lever.
      {=1 nozzle}
  - {?nozzle}
    + You p[P]ush the keel nozzle lever.
      {=0 nozzle}
    + You w[W]ait a bit for the water reservoir to disgorge.
      {->tick} {?conclusion|<-}
  + You a[A]pproach the manifold control station.
    ->manifold
  + You w[W]alk aft along the starboard rail.
    ->starboard
  + You w[W]alk aft along the port rail.
    ->port
  >
  ->forward.options

= manifold
  The manifold control booth contains the solarion gas valve,
  a barometric altimeter, and a vertical anemometer.
  Unlike the common lateral anemometer which you can view over the helm, the
  vertical anemometer is a propellor rotating about a vertical axis, indicating
  the speed of altitude change relative to the surrounding air.
  The anemometer is mounted atop the drakeshead like a propellor beanie.
  ---
  = manifold.options
  The altimeter reads {$altimeter}.
  The solarion tank’s pressure gauge reads {$tank.helium/100}.
  {?anemometer.vertical
  | The anemometer spins {$anemometer.vertical| languidly || forcefully | wildly }
    {$anemometer.vertical.direction|clockwise|counter-clockwise}.
  | The anemometer does not stir.
  }
  - {?manifold.valve}
    + You c[C]lose the manifold gas valve.
      {=0 manifold.valve}
    - {<500 manifold.valve}
      + You t[T]urn the manifold gas valve further open.
        {+100 manifold.valve}
    + You t[T]urn the manifold gas valve one turn toward closed.
      {-100 manifold.valve}
  - {!manifold.valve}
    + You c[C]rack open the manifold gas valve.
      {=100 manifold.valve}
  - {!=500 manifold.valve}
    + You o[O]pen the manifold gas valve wide.
      {=500 manifold.valve}
  - {?manifold.vent}
    + You p[P]ull and secure the manifold vent sheet.
      {=0 manifold.vent}
  - {!manifold.vent}
    + You l[L]oosen the manifold vent sheet, allowing bouyant gasses to escape.
      {=0 manifold.vent}
  + “Steady as he goes].”[,” you say.
    {->tick} {?conclusion|<-}
  + You t[T]are the altimeter to the ambient barometric pressure.
    {=barometric.pressure altimeter.tare}
    {=0 altimeter}
  + You e[E]xit the manifold control booth. ->forward
  >
  ->manifold.options

= stern
  The helm and various gauges, instruments, and controls are here.
  + You a[A]pproach the helm.
    ->helm
  + You w[W]alk forward along the port rail.
    ->port
  + You w[W]alk forward along the starboard rail.
    ->starboard
  >

= helm
  The helm consists of a large spokèd outer wheel that governs the rudder, and
  a pair of smaller wheels that control the port and starboard elevators.
  The helm is flanked by the æleron lever on your portside and the throttle to
  starboard, both with a lever in the handle that releases a locking pin when
  clasped.
  An anemometer indicates lateral wind speed relative to the craft.
  A pennant hung from the mizzen indicates the wind direction.
  ---
  = helm.instruments
  The throttle is {$throttle|closed|open} at position {$throttle}.
  The steam pressure gauge reads {$boiler.pressure}.
  {?drive.speed/10
  | The propellor turns {$drive.direction
    | clockwise
    | counter-clockwise
    } {$drive.speed| slowly|| forcefully| with abandon}.
  | The propellor is idle.
  }
  {?anemometer.lateral
  | The anemometer spins{$anemometer.lateral|| languidly|| forcefully| wildly}.
  | The anemometer does not stir.
  }
  # TODO pennant direction
  = helm.options
  - {!throttle}
    + You c[C]rack open the throttle.
      {+throttle}
  - {<11 throttle}
    + You o[O]pen the throttle wide.
      {=11 throttle}
    - {?throttle ^ (throttle < 10)}
      + You p[P]ush the throttle one step more open.
        {+throttle}
  - {?throttle}
    - {>0 throttle}
      + You p[P]ull the throttle one step toward closed.
        {-throttle}
    + You p[P]ull the throttle fully closed.
      {=0 throttle}
  + “Steady as he goes].”[,” you say.
    {->tick} {?conclusion|<-}
  + You i[I]nspect the boiler gauges.
    {->boiler.gauges} ->helm.options
  + You s[S]tep away from the helm.
    ->stern
  >
  ->helm.instruments

= port
  - {?ballast.port}
    + You l[L]et slip port ballast.
      {-ballast.port}
      {!ballast.port
      | There are no more bags to drop on the port side.
      | There are {$ballast.port} remaining bags to port.
      }
      {->roll} {?conclusion|<-}
    + You l[L]et slip all remaining port ballast.
      {=0 ballast.port}
  + You e[E]nter the boiler shed admiships.
    ->amidships
  - {!plank}
    + You h[H]aul the plank aboard.
      {=1 plank}
    - {?altitude}
      + You w[W]alk the plank. <-
    - {!altitude}
      + You d[D]ebark by the boarding plank. <-
  - {?plank}
    + You h[H]aul the plank outboard.
      {=0 plank}
  + You w[W]alk forward.
    ->forward
  + You w[W]alk astern.
    ->stern
  >
  ->port

= starboard
  - {?ballast.starboard}
    + You l[L]et slip starboard ballast.
      {-ballast.starboard}
      {!ballast.starboard
      | There are no more bags to drop on the starboard side.
      | There are {$ballast.starboard} remaining bags to starboard.
      }
      {->roll} {?conclusion|<-}
    + You l[L]et slip all remaining starboard ballast.
      {=0 ballast.starboard}
  + You e[E]nter the boiler shed admiships.
    ->amidships
  + You w[W]alk forward.
    ->forward
  + You w[W]alk astern.
    ->stern
  >
  ->starboard

= amidships
  There is a boiler here.
  The engine and works are behind the boiler.
  =engine.options
  - {?boiler.cracked}
    A crack has rent through the boiler’s casing, rendering it useless.
  - {!boiler.cracked}
    - {?boiler.door}
      - {?boiler.fire}
        Wood burns in the boiler’s fire box.
        - {?wood}
          + You a[A]dd wood to the fire.
            {->boiler.wood}
            ->engine.options
      - {!boiler.fire}
        - {?boiler.wood}
          Wood stands ready for ignition in the fire box.
          + You u[U]se the match to ignite the boiler.
            {+boiler.fire}
        - {!boiler.wood}
          Naught but cold ash fills the boiler’s fire box.
          - {?wood}
            + You p[P]lace wood in the fire box.
              {->boiler.wood}
              The engineer’s match, an oiled length of rope with a burning wick,
              smoulders in a hasp.
              + You u[U]se the match to ignite the boiler.
                {+boiler.fire}
                ->amidships.exits
              ->amidships.exits
      + You c[C]lose the boiler door. {=0boiler.door}
    - {!boiler.door}
      The fire box hatch is closed.
      + You o[O]pen the boiler door. {=1boiler.door}
    = amidships.exits
    {->boiler.gauges}
    - {?(boiler.water < boiler.capacity.water) ^ (reservoir.water > 0)}
      A water pump stands ready to fill the boiler.
      + You p[P]ump water into the boiler.
        {->boiler.water} ->engine.options
    - {?boiler.fire}
      + You s[S]tand for a bit and wait for the boiler’s gauges to change.
        {->tick} {?conclusion|<-} ->engine.options
  + You d[D]epart the boiler shed on the port side.
    ->port
  + You d[D]epart the boiler shed on the starboard side.
    ->starboard
  >
  ->engine.options

= boiler.gauges
  The boiler’s water level gauge shows
  {>90 boiler.water
  | the meniscus right up to the top|
    {>10 boiler.water
    | the meniscus in the window around {$boiler.water/10} gallons|
      nothing}
  }.
  The temperature gauge reads {$boiler.temperature}.
  The pressure gauge reads {$boiler.pressure}.
  <-

= boiler.wood
  {? wood < boiler.capacity.wood - boiler.wood
  | These are the last {$wood/10} logs aboard.
    {=boiler.wood wood} {=0 wood}
  | The wood fills the boiler.
    {-boiler.capacity.wood - boiler.wood wood} {=100 boiler.wood}
    {$wood/10} split logs remain aboard.
  }
  <-

= boiler.water
  {? reservoir.water < boiler.capacity.water - boiler.water
  | You pump water into the boiler until the reservoir runs dry.
    {=reservoir.water boiler.water}
    {=0 reservoir.water}
  | You pump water until the boiler is full.
    {-boiler.capacity.water - boiler.water reservoir.water}
    {=boiler.capacity.water boiler.water}
  }
  <-

= init
  {=1000       wood}
  {=1000       reservoir.water}
  {=100        boiler.capacity.wood}
  {=100        boiler.capacity.water}
  {=120        boiler.volume}
  {=30000      tank.helium}
  {=10000      manifold.volume}
  {=5          ballast.starboard}
  {=5          ballast.port}
  {=50+10~10   barometric.pressure}
  {=50+10~10   altimeter.tare}
  {->tick}
  <-

= roll
  {= ballast.port - ballast.starboard roll.next }
  {? altitude == 0 | {=0 roll.next}}
  {<0 roll.next |
    {= 0-roll.next roll.magnitude}
    {= 0-1 roll.next}
  }
  {>0 roll.next |
    {= roll.next roll.magnitude}
    {= 1 roll.next}
  }
  {? roll != roll.next |
    {? roll.next > 0
    | The airship lists to port. }
    {? roll.next < 0
    | The airship lists to starboard. }
    {? roll.next == 0
    | The airship’s listing stabilizes. }
  |
    {? roll.next > 0
    | The airship still lists to port. }
    {? roll.next < 0
    | The airship still lists to starboard. }
  }
  {= roll.next roll}
  {>2 roll.magnitude |
    The angle becomes too steep and the masts explode in splinters.
    You plummet from the sky.
    {=3 conclusion}
  }
  <-

= tick
  {+time}
  Time passes.

  # drift the barometric pressure
  {+1~6-3 barometric.pressure}
  {<150 barometric.pressure | {=150+1~10 barometric.pressure}}
  {>250 barometric.pressure | {=250-1~10 barometric.pressure}}

  {?nozzle |
    Water rushes out of the keel.
    {-100 reservoir.water}
    {<0 reservoir.water | {=0 reservoir.water}}
  }

  {?manifold.valve |
    {=manifold.valve manifold.valve.flow}
    {? manifold.valve.flow > tank.helium
    | {=tank.helium manifold.valve.flow}
    }
    {? manifold.volume < manifold.helium + manifold.valve.flow
    | {=manifold.volume - manifold.helium manifold.valve.flow}
    }
    {+manifold.valve.flow manifold.helium}
    {-manifold.valve.flow tank.helium}
  }

  {?manifold.vent |
    {*3 manifold.helium}
    {/4 manifold.helium}
  }

  {*20 manifold.helium}
  {/21 manifold.helium}

  {=
    (manifold.helium / 10) -
    (ballast.starboard * 50) -
    (ballast.port * 50) -
    bolier.water -
    boiler.ash -
    wood -
    reservoir.water
    altitude.target}

  {= (altitude * 10 + altitude.target) / 11 altitude.next }
  {= altitude.next - altitude altitude.change }
  {? (altitude.next < 0) ^ (altitude > 0)
  | {<0-20 altitude.change |
      The airship plummets into land with devestating force, terminating your
      voyage and immediately also your story.
      {=1 conclusion}
    | {>10 speed
      | The airship plows into the ground with its momentum,
        ruining what might otherwise have been a gentle landing.
      | The airship’s keel gently touches down.
        You have travelled {$position/10} leagues since your ascent.
        {=0 position}
      }
    }
    {=0 altitude.next}
  | # recompute change in altutide if there is a chance that it went negative.
    {<0 altitude.next | {=0 altitude.next}}
    {= altitude.next - altitude altitude.change }
  }

  {? (altitude.next > 0) ^ (altitude == 0)
  | The deck lurches upward and the ground falls away beneath the airship.
  }

  {>87 altitude.change | {=87 altitude.change}}
  {<0-87 altitude.change | {=0-87 altitude.change}}
  {+altitude.change altitude}
  {<0 altitude | {=0 altitude}}

  # TODO figure in up and down drafts
  {= altitude.change/10 anemometer.vertical}
  {>0 anemometer.vertical
  | {=0 anemometer.vertical.direction}
  | {=1 anemometer.vertical.direction} {*0-1 anemometer.vertical}
  }

  {= altitude + barometric.pressure - altimeter.tare altimeter}

  {->roll} {?conclusion|<-}

  {!boiler.cracked|

    {?boiler.fire
    | {*2 boiler.fire}
      {>boiler.wood boiler.fire
      | {=boiler.wood boiler.fire}
      }
      {>=5 boiler.wood
      | {+boiler.fire*20 boiler.heat}
        {-5 boiler.wood}
        {+2 boiler.ash}
      }
    }
    {=boiler.water + boiler.steam boiler.equilibrium}
    {? boiler.heat + boiler.water > boiler.equilibrium |
      {=boiler.water + boiler.steam boiler.equilibrium}
    }
    {=(boiler.steam * 4 + boiler.equilibrium)/5 boiler.steam.next}
    {=boiler.steam.next - boiler.steam boiler.delta}
    {-boiler.delta boiler.water}
    {+boiler.delta boiler.steam}

    {=100 * boiler.steam / (boiler.volume - boiler.water) boiler.pressure}

    {*6 boiler.heat}
    {? boiler.door
    | {/9 boiler.heat}
    | {/7 boiler.heat}
    }

    {? boiler.heat > boiler.water
    | {=100 boiler.temperature}
    | {=100*boiler.heat/boiler.water boiler.temperature}
    }

    {? (boiler.heat > 1000) ^ ((boiler.water + boiler.steam) < 100)
    | 
      {=1 boiler.cracked}
      {? boiler.steam > 100
      | The boiler explodes as steam vents through numerous cracks in its
        heat-brittled shell.
        {>40 altitude
        | Shards of the ruptured pressure tank shred through the vessel’s
          tackle and manifold, leaving you briefly weightless and suddenly
          deceased.
          {=2 conclusion}
        | You are fortunate to escape the cataclysm with your life.
        }
      | The boiler rings like a bell and a crack appears along its side.
      }
      ---
    }

    {? throttle
    | {= boiler.pressure / (12 - throttle) engine.pressure}
    | {=0 engine.pressure}
    }

    # produce drive speed
    {= engine.pressure*5 drive.speed.target }
    # asymptotically approach target drive speed
    {= (drive.speed * 4 + drive.speed.target) / 5 drive.speed}
    # consume steam
    {-drive.speed/10 boiler.steam}
    {-drive.speed/10 boiler.heat}
    {<0 boiler.steam | {=0 boiler.steam}}
    {<0 boiler.heat | {=0 boiler.heat}}

    # produce craft speed
    # nominal drag
    {?altitude |
      {*10 speed} {/11 speed}
      # asymptotically approach drive speed divided by vessel weight
      {= boiler.water + reservoir.water + wood + ballast.starboard + ballast.port weight}
      {= (speed * 3 + drive.speed * 100 / weight) / 4 speed}
      {+speed position}
    }

    {= speed anemometer.lateral}

  }
