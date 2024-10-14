Extension { #name : #FFICallout }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
FFICallout >> aliasForType: aTypeName [
	| alias |

	alias := aTypeName.
	(requestor notNil and: [ requestor respondsTo: #externalTypeAlias: ])
		ifTrue: [
			alias := requestor externalTypeAlias: aTypeName.
			alias ifNil: [ alias := aTypeName ] ].
	" internal aliases "
	^ TypeAliases at: alias asSymbol ifAbsent: [ alias ]
]

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
FFICallout >> resolveType: aTypeName [
	" a type name could be
	 - a class variable name
	- a class name
	- a type name
	- a type name, followed by arbitrary number pointer chars - $*"
	| name newName resolver binding ptrArity |

	newName := aTypeName.
	ptrArity := 0.
	"resolve aliases and pointers"
	[
		name := newName asString trimRight.
		newName := self aliasForType: name.
		newName last = $* ifTrue: [
			ptrArity := ptrArity + 1.
			newName := newName allButLast ].
		name sameContentAs: newName
	] whileFalse.

	resolver := requestor
		ifNotNil: [
			requestor isClass
				ifTrue: [ requestor instanceSide ]
				ifFalse: [ requestor ] ]
		ifNil: [ self class ].

	binding := resolver ffiBindingOf: name asSymbol.
	binding ifNotNil: [
		^ (binding value asExternalTypeOn: self) pointerArity: ptrArity ].

	^ self error: 'Unable to resolve external type: ' , aTypeName asString
]
