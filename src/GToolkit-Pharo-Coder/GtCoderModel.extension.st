Extension { #name : #GtCoderModel }

{ #category : #'*GToolkit-Pharo-Coder' }
GtCoderModel class >> gtAstCoderAddOnsFor: aView context: aPhlowContext [
	<gtClassView>
	^ aView forward
		title: 'Coder Addons';
		tooltip: 'The methods that extend the Coder with AddOns';
		priority: 40;
		object: [ 
			(GtSearchMethodsInClassFilter new 
					forClass: self;
					includeSuperclass: true) & 
					#gtAstCoderAddOns: gtPragmas];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Pharo-Coder' }
GtCoderModel class >> gtContextMenuAddOnsFor: aView [
	<gtView>
	<gtClassView>
	^ aView forward
		title: 'Menu AddOns';
		tooltip: 'The methods that extend the Coder with context menu items';
		priority: 45;
		object: [ 
			(GtSearchMethodsInClassFilter new 
					forClass: self;
					includeSuperclass: true) & 
					#gtCoderContextMenuAddOns: gtPragmas];
		view: #gtItemsFor:
]
