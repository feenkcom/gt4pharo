Extension { #name : #FFIFunctionParser }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
FFIFunctionParser >> parseArgument [
	| argument argName indirectIndex typeAndPtrArity next |
	" An argument can be:

 - nil , true , false
 - a class/pool variable name
 - integer literal

 - self , with optional **
 - type name *** arg name

"
	"constant conditions"
	(stream contents size = 1 and: [ stream contents first ~= #void ])
		ifTrue: [ ^ self integerConstantArgument: stream next ].
	stream peek isArray ifTrue: [ ^ self parseArgumentCastedType ].	"none of them, parse type and name"
	typeAndPtrArity := self parseType.
	argName := stream next.
	next := stream peek.
	next = $@
		ifTrue: [ stream next.
			argName := argName.
			indirectIndex := self parseInt ].	"for sole 'void' fake argument "
	((typeAndPtrArity sameContentAs: #('void' 0)) and: [ argName isNil ])
		ifTrue: [ ^ nil ].
	argument := self
			argName: argName
			indirectIndex: indirectIndex
			type: typeAndPtrArity first
			ptrArity: typeAndPtrArity second.

	^ argument
]
