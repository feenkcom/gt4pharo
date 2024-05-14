Extension { #name : #GtPharoSourceCoderEvaluationContext }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoderEvaluationContext >> gtBindingsFor: aView [
	<gtView>
	self bindingStrategy ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Bindings';
		priority: 10;
		object: [ self bindingStrategy ];
		view: #gtBindingsFor:
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoderEvaluationContext >> gtInfo [
	^ Array
		streamContents: [ :aStream | 
			aStream nextPut: #receiverObject -> self receiverObject.
			aStream nextPut: #runtimeContext -> self runtimeContext.
			aStream nextPut: #bindingStrategy -> self bindingStrategy.
			aStream nextPut: #coder -> self coder.
			aStream nextPut: #sourceString -> self sourceString.
			aStream nextPut: #sourceInterval -> self sourceInterval.
			aStream nextPut: #evaluatedSourceString -> self evaluatedSourceString.
			aStream nextPut: #evaluatedInterval -> self evaluatedInterval.
			aStream nextPut: #evaluatedCode -> self evaluatedCode.
			aStream nextPut: #requesterObject -> self requesterObject ]
]

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
GtPharoSourceCoderEvaluationContext >> gtInfoFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Info';
		priority: 0;
		items: [ self gtInfo ];
		actionUpdateButtonTooltip: 'Refresh';
		column: 'Property' 
			text: [ :eachItem :eachIndex | eachItem key asRopedText foreground: Color gray ]
			width: 150;
		column: 'Value' 
			text: [ :eachItem | eachItem value gtDisplayText ];
		send: [ :assoc | assoc value ]
]
