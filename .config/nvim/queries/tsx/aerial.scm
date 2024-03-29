(function_signature
  name: (identifier) @name
  (#set! "kind" "Function")
  ) @symbol

(function_declaration
  name: (identifier) @name
  (#set! "kind" "Function")
  ) @symbol

(generator_function_declaration
  name: (identifier) @name
  (#set! "kind" "Function")
  ) @symbol

(interface_declaration
  name: (type_identifier) @name
  (#set! "kind" "Interface")
  ) @symbol

(class_declaration
  name: (type_identifier) @name
  (#set! "kind" "Class")
  ) @symbol

(method_definition
  name: (property_identifier) @name
  (#set! "kind" "Method")
  ) @symbol

(public_field_definition
  name: (property_identifier) @name
  value: (arrow_function)
  (#set! "kind" "Method")
  ) @symbol

(type_alias_declaration
  name: (type_identifier) @name
  (#set! "kind" "Variable")
  ) @symbol

(lexical_declaration
  (variable_declarator
    name: (identifier) @name
    value: (_) @var_type) @symbol
  (#set! "kind" "Variable")
  ) @start

; describe("Unit test")
(call_expression
  function: (identifier) @method @name (#any-of? @method "describe" "it" "test" "afterAll" "afterEach" "beforeAll" "beforeEach")
  arguments: (arguments
    (string
      (string_fragment) @name @string))?
  (#set! "kind" "Function")
  ) @symbol @selection

; test.skip("this test")
(call_expression
  function: (member_expression
    object: (identifier) @method (#any-of? @method "describe" "it" "test")
    property: (property_identifier) @modifier (#any-of? @modifier "skip" "todo")
  ) @name
  arguments: (arguments
    (string
      (string_fragment) @name @string))?
  (#set! "kind" "Function")
  ) @symbol @selection

; describe.each([])("Test suite")
(call_expression
  function: (call_expression
    function: (member_expression
      object: (identifier) @method (#any-of? @method "describe" "it" "test")
      property: (property_identifier) @modifier (#any-of? @modifier "each")
    ) @name
  )
  arguments: (arguments
    (string
      (string_fragment) @name @string))?
  (#set! "kind" "Function")
  ) @symbol @selection


;; Jsx elements
(_
  [
    (jsx_opening_element (identifier) @name)
  ]
  (#set! "kind" "Struct")
) @symbol


;; Self closing jsx elements
(jsx_self_closing_element
  name: (identifier) @name
  (#set! "kind" "Struct")
  ) @symbol

;; Destructured array variables
; (lexical_declaration
;   (variable_declarator
;     name: (array_pattern (identifier) @name (#gsub! @name "^.*$" "[ %1, .. ]")) 
;     value: (_) @var_type) @symbol
;   (#set! "kind" "Variable")
;   ) @start

(lexical_declaration
  (variable_declarator
    name: (array_pattern (identifier) )@name (#gsub! @name "%s+" "") 
    value: (_) @var_type) @symbol
  (#set! "kind" "Variable")
  ) @start
; (lexical_declaration
;   (variable_declarator
;     name: (array_pattern (_ 
;                            ([(identifier) ] )@name)) 
;     value: (_) @var_type) @symbol
;   (#set! "kind" "Variable")
;   ) @start

;; Destructured object variables
(lexical_declaration
  (variable_declarator
    name: (object_pattern (shorthand_property_identifier_pattern) @name (#gsub! @name "^.*$" "{ %1, .. }")) 
    value: (_) @var_type) @symbol
  (#set! "kind" "Variable")
  ) @start

;; React hooks: useEffect and useLayoutEffect
(call_expression
  function: (identifier) @method @name (#any-of? @method "useEffect" "useLayoutEffect")
  (#set! "kind" "Function")
  ) @symbol @selection
