{
    "extend" : {},
    "implements" : {},
    "members" : {},
    "construct" : {},
    "statics" : {},
    "defer" : {},
}

# Python classes

class QxClassMap(object):
    type =  dict
    keys = {
      extend : QxEntry(type=dict, mandatory=false),
      members : QxEntry(),
    }

class QxEntry(object):
  def __init__(s, type=None, mandatory=false):
    s.type = type || types.StringType | types.NumberType
    s.mandatory = mandatory
    s.keys = []


cmap = QxClassMap()
cmap.keys['members'].keys = {
    _ : entry("members_keys")()
}

def entry(key):
    if key not in symbol_table:
        class foo(base_entry): pass
        symbol_table[key] = foo
    return symbol_table[key]

s = entry("class_keys")
s.keys = {
    'extend' : 0,
    'members': 0,
    'statics': 0,
    'defer'  : 0,
}


class_map = map({
    'extend' : id(),
    'members': map({
       '_' : js_val() # closures, identifiers, maps
    }),
    'properties' : map({
       '_' : property() 
    }),
    'defer'  : 0
})

class property(entry): 
    'nullable' : bool(),
    'apply'    : js_function(),
    'event'    : js_id(),


schema['event'].check(node)

class_map.check(rootnode)
    # will raise if (a) unknown keys are there
    # (b) mandatory keys are not there
    # (c) existing keys do not match the schema

# Double Traversal

def check(node, schema_node):
    # check current node against schema_node
    check_single_node(node, schema_node)

    # check child node set
    # (a) existing nodes are allowed
    for c in node.children:
        assert c.name in schema_node.keys
    # (b) no mandatory node is missing
    for k in schema_node.keys:
        if schema_node.keys[k].mandatory:
            assert k in [c.name for c in node.children]

    # handle child nodes
    for c in node.children:
        check(c, schema_node.keys[c.name])

def check_single_node(node, schema_node):
    assert node.type == schema_node.type


















