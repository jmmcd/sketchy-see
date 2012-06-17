# Using the fat arrow instead of the thin arrow ensures that the
# function context will be bound to the local one. For example:

this.clickHandler = -> alert "clicked"
element.addEventListener "click", (e) => this.clickHandler(e)


# If you're using a null check before accessing a property, you can
# skip that by placing the existential operator right before it. This
# is similar to Active Support's try method.

blackKnight.getLegs()?.kick()

# Similarly you can check that a property is actually a function, and
# callable, by placing the existential operator right before the
# parens. If the property doesn't exist, or isn't a function, it
# simply won't get called.

blackKnight.getLegs().kick?()

# :: is an alias for prototype

User::first = -> @records[0]