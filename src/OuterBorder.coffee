
{Style, Element} = require "react-validators"
{AnimatedValue} = require "Animated"

ReactComponent = require "modx/lib/Component"
hexToRgb = require "hex-rgb"
Device = require "modx/lib/Device"
isType = require "isType"
View = require "modx/lib/View"

type = ReactComponent "OuterBorder"

type.defineProps
  style: Style
  child: Element
  width: Number.withDefault 1 / Device.scale
  color: String.withDefault "#000"
  opacity: Number.withDefault 1
  radius: Number

type.defineReactions

  _borderColor: ->
    rgb = hexToRgb(getValue @props.color).join ","
    opacity = getValue @props.opacity
    "rgba(#{rgb}, #{opacity})"

  _borderRadius: ->
    width = getValue @props.width
    radius = getValue @props.radius
    radius + width

type.render ->

  style =
    borderColor: @_borderColor
    borderRadius: @_borderRadius
    borderWidth: @props.width

  return View
    style: [@props.style, style]
    children: @props.child

module.exports = type.build()

getValue = (x) ->
  if isType x, AnimatedValue
  then x.get()
  else x
