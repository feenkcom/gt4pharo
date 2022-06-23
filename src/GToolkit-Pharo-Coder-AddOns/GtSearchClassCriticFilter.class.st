Class {
	#name : #GtSearchClassCriticFilter,
	#superclass : #GtSearchClassesFilter,
	#instVars : [
		'critic'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtSearchClassCriticFilter >> critic: aClassCritic [
	critic := aClassCritic
]

{ #category : #accessing }
GtSearchClassCriticFilter >> includesClass: aClass [
	^ (critic matches: aClass instanceSide from: self)
		or: [ critic matches: aClass classSide from: self ]
]
