(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)

class CellularAutomaton inherits IO {
    population_map : String;
   
    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };

    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };
   
    num_cells() : Int {
        population_map.length()
    };
   
    cell(position : Int) : String {
        population_map.substr(position, 1)
    };
   
    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };
   
    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };
   
    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            '.'
        fi
    };
   
    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells[] in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };
};

class Main {
    cells : CellularAutomaton;
   
    main() : SELF_TYPE {
        {
            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    
                pool
            );  (* end let countdown *)
            self;
        }
    };
};

-- OUR TEST CASES IN ADDITION TO THINGS TESTED ABOVE

(*
fdafdafdsfdaf
fsdafsdafsdafas
fdsfsadfsadfsads
dfadfsadfsdafsdafsdafsda	
*)
class {
	num: INT <- 3;
	main(): SELF_TYPE {
		self
	};
};
4 5
6
--VARIOUS STRING TESTS
"This is a one line string constant"
"This is an two line \
String constant"

"This is an two-line
Which should be error"

"\h\e\l\l\o"

"cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164"
"cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164\
cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164\
cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164\
cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164\
cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164\
cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164cs164"
"String has null  character"
"String has backslash null \ character" 
"String has backslash null \ character \ 
with a new line"
--KEYWORD TESTS
class
else
false
fi
if
in
inherits
isvoid
let
loop
pool
then
while
case
esac
new
of
not
true
-- BLOCK COMMENT NESTING TEST
(* hello (* good nest *) *)
*)
(* *) *)
true
false
-- TESTS FROM TESTS FOLDER
(* various forms of whitespace *)
0
        (* blanks *)
1
      (* formfeed *)
2
      (* carriage return *)
3
    (* tab *)
4
      (* vertical tab *)
5
Cool is not C:

0xabc    -- two tokens, "0" and "xabc"
0987     -- *not* illegal!
(* some string literals *)
"foo"
"\b\t\n\f"
"a\
b"
"1\"2'3~4\"5"
(* hairy  . . .*)

class Foo inherits Bazz {
     a : Razz <- case self of
              n : Razz => (new Bar);
              n : Foo => (new Razz);
              n : Bar => n;
             esac;

     b : Int <- a.doh() + g.doh() + doh() + printh();

     doh() : Int { (let i : Int <- h in { h <- h + 2; i; } ) };

};

class Bar inherits Razz {

     c : Int <- doh();

     d : Object <- printh();
};


class Razz inherits Foo {

     e : Bar <- case self of
          n : Razz => (new Bar);
          n : Bar => n;
        esac;

     f : Int <- a@Bazz.doh() + g.doh() + e.doh() + doh() + printh();

};

class Bazz inherits IO {

     h : Int <- 1;

     g : Foo  <- case self of
                n : Bazz => (new Foo);
                n : Razz => (new Bar);
            n : Foo  => (new Razz);
            n : Bar => n;
          esac;

     i : Object <- printh();

     printh() : Int { { out_int(h); 0; } };

     doh() : Int { (let i: Int <- h in { h <- h + 1; i; } ) };
};

(* scary . . . *)
class Main {
  a : Bazz <- new Bazz;
  b : Foo <- new Foo;
  c : Razz <- new Razz;
  d : Bar <- new Bar;

  main(): String { "do nothing" };

};
(* models one-dimensional cellular automaton on a circle of finite radius
   arrays are faked as Strings,
   X's respresent live cells, dots represent dead cells,
   no error checking is done *)
class CellularAutomaton inherits IO {
    population_map : String;
   
    init(map : String) : SELF_TYPE {
        {
            population_map <- map;
            self;
        }
    };
   
    print() : SELF_TYPE {
        {
            out_string(population_map.concat("\n"));
            self;
        }
    };
   
    num_cells() : Int {
        population_map.length()
    };
   
    cell(position : Int) : String {
        population_map.substr(position, 1)
    };
   
    cell_left_neighbor(position : Int) : String {
        if position = 0 then
            cell(num_cells() - 1)
        else
            cell(position - 1)
        fi
    };
   
    cell_right_neighbor(position : Int) : String {
        if position = num_cells() - 1 then
            cell(0)
        else
            cell(position + 1)
        fi
    };
   
    (* a cell will live if exactly 1 of itself and it's immediate
       neighbors are alive *)
    cell_at_next_evolution(position : Int) : String {
        if (if cell(position) = "X" then 1 else 0 fi
            + if cell_left_neighbor(position) = "X" then 1 else 0 fi
            + if cell_right_neighbor(position) = "X" then 1 else 0 fi
            = 1)
        then
            "X"
        else
            '.'
        fi
    };
   
    evolve() : SELF_TYPE {
        (let position : Int in
        (let num : Int <- num_cells[] in
        (let temp : String in
            {
                while position < num loop
                    {
                        temp <- temp.concat(cell_at_next_evolution(position));
                        position <- position + 1;
                    }
                pool;
                population_map <- temp;
                self;
            }
        ) ) )
    };
};

class Main {
    cells : CellularAutomaton;
   
    main() : SELF_TYPE {
        {
            cells <- (new CellularAutomaton).init("         X         ");
            cells.print();
            (let countdown : Int <- 20 in
                while countdown > 0 loop
                    {
                        cells.evolve();
                        cells.print();
                        countdown <- countdown - 1;
                    
                pool
            );  (* end let countdown
            self;
        }
    };
};
