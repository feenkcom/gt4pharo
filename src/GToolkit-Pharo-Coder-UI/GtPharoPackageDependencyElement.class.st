Class {
	#name : #GtPharoPackageDependencyElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'packageDependency',
		'header'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #initialization }
GtPharoPackageDependencyElement >> initialize [
	super initialize.
	
	self
		alignTopCenter;
		matchParent;
		cellSpacing: 20;
		padding: (BlInsets left: 20 right: 20);
		background: Color white.
	
	header := BrVerticalPane new
		fitContent;
		alignCenter;
		padding: (BlInsets top: 10 bottom: 10 left: 20 right: 20);
		background: Color white;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		addAptitude: BrShadowAptitude.

	self addChild: header
]

{ #category : #accessing }
GtPharoPackageDependencyElement >> packageDependency [

	^ packageDependency
]

{ #category : #accessing }
GtPharoPackageDependencyElement >> packageDependency: anObject [
	packageDependency := anObject.

	header removeChildren.
	header addChild: (BrHorizontalPane new
		fitContent;
		alignCenter;
		addChildren: { 
				BrButton new
					aptitude: BrGlamorousLinkButtonWithLabelAptitude;
					label: packageDependency packageName;
					action: [ :aButton | aButton phlow spawnObject: packageDependency package ].

				BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					text: 'depends on'.

				BrButton new
					aptitude: BrGlamorousLinkButtonWithLabelAptitude;
					label: packageDependency dependencyPackageName;
					action: [ :aButton | aButton phlow spawnObject: packageDependency dependencyPackage ].
			}).
	
	packageDependency baselineStatuses do: [ :eachBaselineStatus |
		header addChild: (BrHorizontalPane new
			fitContent;
			margin: (BlInsets top: 10);
			alignCenter;
			addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: eachBaselineStatus statusPrefix uncapitalized);
			addChildren: (eachBaselineStatus baselines asArray collect: [ :eachBaseline |
				BrButton new
					aptitude: BrGlamorousLinkButtonWithLabelAptitude;
					label: eachBaseline name;
					action: [ :aButton | aButton phlow spawnTool: (GtClassCoderTool forClass: eachBaseline) ] ])) ].

	(packageDependency gtDependenciesFor: GtPhlowEmptyView new)
		asElementDo: [ :aList |
			aList
				vFitContentLimited;
				hMatchParent;
				padding: (BlInsets top: 10 bottom: 10 left: 10 right: 10);
				background: Color white;
				addAptitude: BrShadowAptitude;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
			self addChild: aList ]
]
