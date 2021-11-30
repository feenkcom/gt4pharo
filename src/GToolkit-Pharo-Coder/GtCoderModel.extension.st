Extension { #name : #GtCoderModel }

{ #category : #'*GToolkit-Pharo-Coder' }
GtCoderModel class >> gtAstCoderAddOnsFor: aView context: aPhlowContext [
	<gtClassView>
	^ aView forward
		title: 'Coder Addons';
		tooltip: 'The methods that extend the Coder with AddOns';
		priority: 40;
		object: [ 
			#gtAstCoderAddOns: gtPragmas
				& (GtSearchMethodsInClassFilter new 
					forClass: self;
					includeSuperclass: true) ];
		view: #gtItemsFor:
]
