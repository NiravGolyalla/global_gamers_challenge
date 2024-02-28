import 'package:flame/collisions.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/src/game/overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'config.dart';

import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/rendering.dart';

class PlayArea extends RectangleComponent with HasGameRef<GameOne> {
  PlayArea() : super(paint: Paint()..color = const Color(0xfff2e8cf));

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}

class DragComponent extends PositionComponent with DragCallbacks,CollisionCallbacks {
  DragComponent(position,String _tag) : super(size: Vector2(90, 90), position: position){
    tag = _tag;
  }
  late String tag;
  final paint = Paint();
  bool dragging = false;
  
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if(other is DropComponent && dragging == false){
      removeFromParent();
    }
  }

  @override
  void onDragStart(DragStartEvent event) {dragging = true;}
  
  @override
  void onDragUpdate(DragUpdateEvent event) {position += event.localDelta;}
  
  @override
  void onDragEnd(DragEndEvent event) {dragging = false;}

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    paint.color = dragging ? const Color(0xffff0000) : const Color(0xff00ff00);
    canvas.drawRect(size.toRect(), paint);
  }
}

class DropComponent extends PositionComponent with CollisionCallbacks {
  late String tag;
  DropComponent(Vector2 _position,String _tag) {
    this.position = _position;
    tag = _tag;
    size = Vector2(90, 90);
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(size.toRect(), paint);
  }
}

class GameOne extends FlameGame with HasCollisionDetection{
  var score = 0;

  GameOne(): super(camera: CameraComponent.withFixedResolution(width: gameWidth, height: gameHeight));
  List<String> garbageCategories = [
    'Recyclable',
    'Non-Recyclable',
  ];

  
  double get width => size.x;
  double get height => size.y;

  void addNewDrop() {
    final random = Random();
    final randomIndex = random.nextInt(garbageCategories.length);
    final randomCategory = garbageCategories[randomIndex];
    world.add(DragComponent(size / 2 - Vector2.all(45), randomCategory));  
  }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());

    final List<DropComponent> dropComponents = [];
    final double rowYPosition = size.y / 3;

    for (var i = 0; i < garbageCategories.length; i++) {
      final category = garbageCategories[i];
      final dropPosition = Vector2((i + 1) * size.x / (garbageCategories.length + 1) - size.x / (garbageCategories.length + 1) / 2, rowYPosition);
      dropComponents.add(DropComponent(dropPosition, category));
    }

    world.addAll(dropComponents);
    world.add(DragComponent(size / 2 - Vector2.all(45), 'Recyclable'));  
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(world.children.whereType<DragComponent>().isEmpty) {
      addNewDrop();
    }
  }
}
