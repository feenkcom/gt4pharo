Extension { #name : #GtPharoPackageCoder }

{ #category : #'*GToolkit-Pharo-Extensions' }
GtPharoPackageCoder >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Package';
		priority: 1;
		stencil: [ self ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			action: [ :aButton | aButton phlow spawnTool: (GtPackageCoderTool forPackage: self package) ]
]
