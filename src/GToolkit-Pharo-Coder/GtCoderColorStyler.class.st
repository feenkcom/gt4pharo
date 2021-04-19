Class {
	#name : #GtCoderColorStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #accessing }
GtCoderColorStyler >> visitMessageSend: aMessageSendNode [
	| color receiver |
	super visitMessageSend: aMessageSendNode.
	aMessageSendNode receiver isVariable ifFalse: [^ self].
	receiver := aMessageSendNode receiver variableName.
	receiver = #Color ifFalse: [ ^ self].
	(aMessageSendNode message arguments allSatisfy: #isLiteral) ifFalse: [ ^ self].
	aMessageSendNode message selector = 'r:g:b:range:' ifTrue: [
		color := Color 
			r: aMessageSendNode arguments first literalValue 
			g: aMessageSendNode arguments second literalValue
			b: aMessageSendNode arguments third literalValue
			range: aMessageSendNode arguments fourth literalValue.
		(self 
			attribute: ((BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [
					BlElement new size: 10@10; background: color; when: BlClickEvent do: [:e | e target phlow spawnObject: color]]))
			from: aMessageSendNode stopPosition
			to: aMessageSendNode stopPosition)
	].
	aMessageSendNode message selector = #'fromHexString:' ifTrue: [
		color := Color 
			fromHexString: aMessageSendNode arguments first literalValue.
		(self 
			attribute: ((BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [
					BlElement new size: 10@10; background: color; when: BlClickEvent do: [:e | e target phlow spawnObject: color]]))
			from: aMessageSendNode stopPosition
			to: aMessageSendNode stopPosition)
	].
]
