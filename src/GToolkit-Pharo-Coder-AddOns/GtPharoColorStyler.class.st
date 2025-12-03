"
I display a color next to {{gtClass:Color}} messages.
#Examples
##Hex String
The following example shows how a {{gtMethod:Color class >> #fromHexString: | label=#selector}} looks like directly in the code: {{gtExample:GtPharoColorStylerExamples >> #colorFromHexStringSourceCode}}
##RGB Range Values
The following example shows how a {{gtMethod:Color class >> #r:g:b:range: | label=#selector}} looks like directly in the code: {{gtExample: GtPharoColorStylerExamples >> #colorFromRGBRangeSourceCode }}
##Color Registry
The following example shows how a {{gtMethod:Color class >> #brickColorRegistry | label=#selector}} colors looks like directly in the code: {{ gtExample: GtPharoColorStylerExamples >> #colorFromColorRegistrySourceCode }}
"
Class {
	#name : #GtPharoColorStyler,
	#superclass : #GtGenericPharoStyler,
	#category : 'GToolkit-Pharo-Coder-AddOns-Color'
}

{ #category : #'private - styling' }
GtPharoColorStyler >> styleFromString: aMessageSendNode [
	| color |
	color := Color
		fromHexString: aMessageSendNode arguments first literalValue.
	self styleNode: aMessageSendNode withColor: color
]

{ #category : #'private - styling' }
GtPharoColorStyler >> styleNode: aMessageSendNode withColor: aColor [
	self
		attribute:
			(BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [
					BlElement new
						size: 10 @ 10;
						background: aColor;
						addAptitude: (BrGlamorousWithExplicitDropdownAptitude
							handle: [
								BlElement new
									size: 10 @ 10;
									background: aColor ]
							content: [
								BlElement new
									size: 100@100;
									background: aColor
						]) ])
		from: aMessageSendNode stopPosition
		to: aMessageSendNode stopPosition
]

{ #category : #'private - styling' }
GtPharoColorStyler >> styleRegisteredColor: aMessageSendNode [
	| color |
	color := Color brickColorRegistry at: aMessageSendNode message selector ifAbsent: [ ^ self ].
	self styleNode: aMessageSendNode withColor: color.
]

{ #category : #'private - styling' }
GtPharoColorStyler >> styleRgbRange: aMessageSendNode [
	| color |
	color := Color
		r: aMessageSendNode arguments first literalValue
		g: aMessageSendNode arguments second literalValue
		b: aMessageSendNode arguments third literalValue
		range: aMessageSendNode arguments fourth literalValue.
	self styleNode: aMessageSendNode withColor: color
]

{ #category : #generated }
GtPharoColorStyler >> visitMessageSend: aMessageSendNode [
	| receiver |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable ifFalse: [ ^ self ].
	receiver := aMessageSendNode receiver variableName.
	receiver = #Color ifFalse: [ ^ self ].
	(aMessageSendNode message arguments allSatisfy: #isLiteral) ifFalse: [ ^ self ].
	aMessageSendNode message selector = #r:g:b:range:
		ifTrue: [ self styleRgbRange: aMessageSendNode ].
	aMessageSendNode message selector = #fromHexString:
		ifTrue: [ self styleFromString: aMessageSendNode ].
	(Color brickColorRegistry includesKey: aMessageSendNode message selector)
		ifTrue: [ self styleRegisteredColor: aMessageSendNode ]
]
