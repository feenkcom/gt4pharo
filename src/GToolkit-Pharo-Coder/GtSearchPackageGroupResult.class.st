Class {
	#name : #GtSearchPackageGroupResult,
	#superclass : #GtSearchTypedGroupResult,
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : #enumerating }
GtSearchPackageGroupResult >> refreshItems [
	self refreshPackages
]

{ #category : #enumerating }
GtSearchPackageGroupResult >> refreshPackages [
	| packages |
	filtered
		ifTrue: [ ^ self ].
	packages := OrderedCollection new.
	filter ifNotNil: [ 
		scope packagesDo: [ :eachPackage | 
			(filter matches: eachPackage) ifTrue: [
				packages add: eachPackage ] ] ].
	packages
		sort: [ :a :b | a name < b name ].
	items := packages.
	filtered := true.
]
