Extension { #name : #BlDevScripterMethodReference }

{ #category : #'*GToolkit-Pharo-Coder-Method-UI' }
BlDevScripterMethodReference >> gtReferenceFor: aView [
	<gtView>
	self definition ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		priority: 5;
		actionButtonIcon: BrGlamorousVectorIcons browse 
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: 
				(GtMethodCoderTool compiledMethod: self definition compiledMethod) ];
		stencil: [ 
			 ((GtPharoMethodCoder forMethod: self definition compiledMethod) 
				subscribeToSystem;
				in: [ :theCoder | theCoder addOns addStyler: (GtPharoInterestingIntervalStyler new interval: interval) ];
				asExpandedOnlyElement) vFitContentLimited ].
]
