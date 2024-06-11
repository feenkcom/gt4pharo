Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder' }
Behavior >> gtAdviceDefinitionsFor: aView [
	<gtView>
	<gtClassView>
	^(aView forward)
		title: 'Advice definitions';
		tooltip: 'The methods that define custom advices for the object';
		priority: 100;
		object: 
				[((GtSearchMethodsInClassFilter new)
					forClass: self class;
					includeSuperclass: true) | ((GtSearchMethodsInClassFilter new)
								forClass: self;
								includeSuperclass: true)
					& #gtAdvice gtPragmas];
		view: #gtItemsFor:
]
