const graphics = @import("didot-graphics");
const zlm = @import("zlm");
const std = @import("std");
usingnamespace @import("assets.zig");

const Mesh = graphics.Mesh;
const Window = graphics.Window;
const Material = graphics.Material;
const Allocator = std.mem.Allocator;

pub const GameObjectArrayList = std.ArrayList(GameObject);

/// Mesh of a plane.
pub var PrimitivePlaneMesh: Mesh = undefined;
/// Mesh of a cube.
pub var PrimitiveCubeMesh: Mesh = undefined;

/// Material must be set manually.
/// Memory is caller owned
/// initPrimitives() must have been called before calling this function!
pub fn createSkybox(allocator: *Allocator) !GameObject {
    var go = GameObject.createCustom(allocator, "skybox", 0);
    return go;
}

/// This function must be called before primitive meshes (like PrimitiveCubeMesh) can be used.
/// Since it create meshes it must be called after the window context is set.
/// It is also automatically called by didot-app.Application
pub fn initPrimitives() void {
    var planeVert = [_]f32 {
        -0.5, 0.5, 0.0, 0.0, 0.0,
        0.5, 0.5, 0.0, 1.0, 0.0,
        0.5, -0.5, 0.0, 1.0, 1.0,
        -0.5, -0.5, 0.0, 0.0, 1.0
    };
    var planeElem = [_]graphics.MeshElementType {
        0, 1, 2,
        2, 3, 0
    };
    PrimitivePlaneMesh = Mesh.create(planeVert[0..], planeElem[0..]);

    // position, normal, tex coords
    // var cubeVert = [_]f32 {
    //     // front
    //     -0.5, 0.5, 0.5, 0.0, 0.0, 1.0, 0.0, 0.0, // upper left
    //     0.5, 0.5, 0.5, 0.0, 0.0, 1.0, 1.0, 0.0, // upper right
    //     0.5, -0.5, 0.5, 0.0, 0.0, 1.0, 1.0, 1.0, // bottom right
    //     -0.5, -0.5, 0.5, 0.0, 0.0, 1.0, 0.0, 1.0, // bottom left
    //     // bottom
    //     -0.5, -0.5, -0.5, 0.0, -1.0, 0.0, 0.0, 0.0, // bottom left
    //     0.5, -0.5, -0.5, 0.0, -1.0, 0.0, 1.0, 0.0, // bottom right
    //     // right
    //     -0.5, 0.5, -0.5, 1.0, 0.0, 1.0, 1.0, 0.0, // upper left
    //     -0.5, -0.5, -0.5, 1.0, 0.0, -1.0, 1.0, 1.0, // bottom left
    //     // left
    //     0.5, 0.5, -0.5, -1.0, 0.0, 0.0, 0.0, 0.0, // upper left
    //     0.5, -0.5, -0.5, -1.0, 0.0, 0.0, 0.0, 1.0, // bottom left
    //     // top
    //     -0.5, 0.5, -0.5, 0.0, 1.0, 0.0, 0.0, 1.0, // top left
    //     0.5, 0.5, -0.5, 0.0, 1.0, 0.0, 1.0, 1.0, // top right
    // };
    // var cubeElem = [_]graphics.MeshElementType {
    //     // front
    //     0, 1, 3,
    //     1, 3, 2,
    //     // bottom
    //     3, 2, 4,
    //     2, 5, 4,
    //     // right
    //     0, 3, 6,
    //     3, 6, 7,
    //     // left
    //     1, 2, 8,
    //     2, 8, 9,
    //     // top
    //     0, 1, 10,
    //     1, 11, 10,
    // };
    //PrimitiveCubeMesh = Mesh.create(cubeVert[0..], cubeElem[0..]);

    var cubeVert = [_]f32{
        // back
        -0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 0.0,
         0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 0.0,
         0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 1.0,
         0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 1.0, 1.0,
        -0.5,  0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 1.0,
        -0.5, -0.5, -0.5,  0.0,  0.0, -1.0, 0.0, 0.0,

        // front
        -0.5, -0.5,  0.5,  0.0,  0.0, 1.0, 0.0, 0.0,
         0.5, -0.5,  0.5,  0.0,  0.0, 1.0, 1.0, 0.0,
         0.5,  0.5,  0.5,  0.0,  0.0, 1.0, 1.0, 1.0,
         0.5,  0.5,  0.5,  0.0,  0.0, 1.0, 1.0, 1.0,
        -0.5,  0.5,  0.5,  0.0,  0.0, 1.0, 0.0, 1.0,
        -0.5, -0.5,  0.5,  0.0,  0.0, 1.0, 0.0, 0.0,

        // left
        -0.5,  0.5,  0.5, -1.0,  0.0,  0.0, 0.0, 1.0,
        -0.5,  0.5, -0.5, -1.0,  0.0,  0.0, 1.0, 1.0,
        -0.5, -0.5, -0.5, -1.0,  0.0,  0.0, 1.0, 0.0,
        -0.5, -0.5, -0.5, -1.0,  0.0,  0.0, 1.0, 0.0,
        -0.5, -0.5,  0.5, -1.0,  0.0,  0.0, 0.0, 0.0,
        -0.5,  0.5,  0.5, -1.0,  0.0,  0.0, 0.0, 1.0,

        // right
         0.5,  0.5,  0.5,  1.0,  0.0,  0.0, 0.0, 1.0,
         0.5,  0.5, -0.5,  1.0,  0.0,  0.0, 1.0, 1.0,
         0.5, -0.5, -0.5,  1.0,  0.0,  0.0, 1.0, 0.0,
         0.5, -0.5, -0.5,  1.0,  0.0,  0.0, 1.0, 0.0,
         0.5, -0.5,  0.5,  1.0,  0.0,  0.0, 0.0, 0.0,
         0.5,  0.5,  0.5,  1.0,  0.0,  0.0, 0.0, 1.0,

        // bottom
        -0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
         0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
         0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
         0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
        -0.5, -0.5,  0.5,  0.0, -1.0,  0.0, 0.0, 0.0,
        -0.5, -0.5, -0.5,  0.0, -1.0,  0.0, 0.0, 0.0,

        // top
        -0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 0.0, 0.0,
         0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 1.0, 0.0,
         0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 1.0, 1.0,
         0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 1.0, 1.0,
        -0.5,  0.5,  0.5,  0.0,  1.0,  0.0, 0.0, 1.0,
        -0.5,  0.5, -0.5,  0.0,  1.0,  0.0, 0.0, 0.0,
    };
    PrimitiveCubeMesh = Mesh.create(cubeVert[0..], null);
}

pub const GameObject = struct {
    //mesh: ?Mesh = null,
    meshPath: ?[]const u8 = null,
    name: []const u8 = "Game Object",
    /// Functions called regularly depending on the updateTarget value of the Application.
    updateFn: ?fn(allocator: *Allocator, gameObject: *GameObject, delta: f32) anyerror!void = null,
    position: zlm.Vec3 = zlm.Vec3.zero,
    /// In order: yaw, pitch, roll.
    /// Note: this will be replaced with quaternions very soon!
    rotation: zlm.Vec3 = zlm.Vec3.zero,
    scale: zlm.Vec3 = zlm.Vec3.one,
    childrens: GameObjectArrayList,

    /// Type of object owning this game object ("camera", "scene", etc.)
    objectType: ?[]const u8 = null,
    /// Pointer to the struct of the object owning this game object.
    /// To save space, it must be considered null when objectType is null.
    objectPointer: usize = 0,
    /// The allocator used to create objectPointer, if any.
    objectAllocator: ?*Allocator = null,
    material: Material = Material.default,

    /// To be used for game objects entirely made of other game objects as childrens, or for script-only game objects.
    pub fn createEmpty(allocator: *Allocator) GameObject {
        var childs = GameObjectArrayList.init(allocator);
        return GameObject {
            .childrens = childs
        };
    }

    /// The default kind of game object, it is renderable via its mesh and material.
    pub fn createObject(allocator: *Allocator, meshPath: []const u8) GameObject {
        var childs = GameObjectArrayList.init(allocator);
        return GameObject {
            .childrens = childs,
            .meshPath = meshPath
        };
    }

    /// For cameras, scenes, etc.
    pub fn createCustom(allocator: *Allocator, customType: []const u8, ptr: usize) GameObject {
        var childs = GameObjectArrayList.init(allocator);
        return GameObject {
            .childrens = childs,
            .objectType = customType,
            .objectPointer = ptr,
            .objectAllocator = allocator
        };
    }

    pub fn update(self: *GameObject, allocator: *Allocator, delta: f32) anyerror!void {
        if (self.updateFn) |func| {
            try func(allocator, self, delta);
        }
        for (self.childrens.items) |*child| {
            try child.update(allocator, delta); // TODO: correctly handle errors
        }
    }

    pub fn findChild(self: *const GameObject, name: []const u8) ?*GameObject {
        for (self.childrens.items) |*child| {
            if (std.mem.eql(u8, child.name, name)) return child;
        }
        return null;
    }

    /// This functions returns the forward (the direction) vector of this game object using its rotation.
    pub fn getForward(self: *const GameObject) zlm.Vec3 {
        const rot = self.rotation;
        return zlm.Vec3.new(
            std.math.cos(rot.x) * std.math.cos(rot.y),
            std.math.sin(rot.y),
            std.math.sin(rot.x) * std.math.cos(rot.y)
        );
    }

    /// This functions returns the left vector of this game object using its rotation.
    pub fn getLeft(self: *const GameObject) zlm.Vec3 {
        const rot = self.rotation;
        return zlm.Vec3.new(
            -std.math.sin(rot.x),
            0,
            std.math.cos(rot.x)
        );
    }

    pub fn look(self: *GameObject, direction: zlm.Vec3, up: zlm.Vec3) void {
        // self.rotation.x = ((std.math.cos(direction.z)) * (std.math.cos(direction.x)) +1)* std.math.pi;
        // self.rotation.y = (std.math.cos(direction.y) + 1) * std.math.pi;
        // self.rotation.z = 0;
        // const mat = zlm.Mat4.createLook(self.position, direction, up);
        // self.rotation = mat.mulVec3(zlm.Vec3.new(0, 0, 1));
        // self.rotation.x = (self.rotation.x * self.rotation.z) * std.math.pi;
        // self.rotation.y = 0;
        // self.rotation.z = 0;

        var angle = std.math.atan2(f32, direction.y, direction.x);
        
    }

    pub fn lookAt(self: *GameObject, target: zlm.Vec3, up: zlm.Vec3) void {
        self.look(target.sub(self.position).normalize(), up);
    }

    /// Add a game object as children to this game object.
    pub fn add(self: *GameObject, go: GameObject) !void {
        try self.childrens.append(go);
    }

    /// Frees childrens array list (not childrens themselves!), the object associated to it and itself.
    pub fn deinit(self: *const GameObject) void {
        self.childrens.deinit();
        if (self.objectAllocator) |alloc| {
            if (self.objectPointer != 0) {
                alloc.destroy(@intToPtr(*u8, self.objectPointer));
            }
        }
    }

    /// De-init the game object and its children (recursive deinit)
    pub fn deinitAll(self: *const GameObject) void {
        for (self.childrens.items) |*child| {
            child.deinitAll();
        }
        self.deinit();
    }
};

pub const Camera = struct {
    fov: f32,
    gameObject: GameObject,
    viewMatrix: zlm.Mat4,
    shader: graphics.ShaderProgram,
    skyboxShader: ?graphics.ShaderProgram,

    /// Memory is caller-owned (de-init must be called before)
    pub fn create(allocator: *Allocator, shader: graphics.ShaderProgram) !*Camera {
        var camera = try allocator.create(Camera);
        var go = GameObject.createCustom(allocator, "camera", @ptrToInt(camera));
        go.rotation = zlm.Vec3.new(zlm.toRadians(-90.0), 0, 0);
        camera.gameObject = go;
        camera.shader = shader;
        camera.fov = 70;
        return camera;
    }

    pub fn deinit(self: *const Camera) void {
        self.gameObject.deinit();
    }
};

pub const PointLight = struct {
    gameObject: GameObject,
    color: graphics.Color,
    /// Constant attenuation (the higher it is, the darker the light is)
    constant: f32,
    /// Linear attenuation
    linear: f32,
    /// Quadratic attenuation
    quadratic: f32,

    pub fn create(allocator: *Allocator) !*PointLight {
        var light = try allocator.create(PointLight);
        var go = GameObject.createCustom(allocator, "point_light", @ptrToInt(light));
        light.gameObject = go;
        light.color = zlm.Vec3.one;
        light.constant = 1.0;
        light.linear = 0.018;
        light.quadratic = 0.016;
        return light;
    }
};

pub const Scene = struct {
    gameObject: GameObject,
    /// The camera the scene is currently using.
    /// It is auto-detected at runtime before each render by looking
    /// on top-level game objects to select one that corresponds
    /// to the "camera" type.
    camera: ?*Camera,
    /// The skybox the scene is currently using.
    /// It is auto-detected at runtime before each render by looking
    /// on top-level game objects to select one that corresponds
    /// to the "skybox" type.
    skybox: ?*GameObject,
    pointLight: ?*PointLight,
    assetManager: AssetManager,

    pub fn create(allocator: *Allocator, assetManager: ?AssetManager) !*Scene {
        var scene = try allocator.create(Scene);
        scene.gameObject = GameObject.createCustom(allocator, "scene", @ptrToInt(scene));
        if (assetManager) |mg| {
            scene.assetManager = mg;
        } else {
            scene.assetManager = AssetManager.init(allocator);
        }
        return scene;
    }

    pub fn loadFromFile(allocator: *Allocator, path: []const u8) !Scene {
        const file = try std.fs.cwd().openFile(path, .{ .read = true });
        defer file.close();

        const text = try reader.readAllAlloc(allocator, std.math.maxInt(usize));
        defer allocator.free(text);

        return Scene.loadFromMemory(allocator, text);
    }

    pub fn loadFromMemory(allocator: *Allocator, json: []const u8) !Scene {
        std.debug.warn("{}\n", .{json});
    }

    pub fn render(self: *Scene, window: Window) !void {
        var childs: GameObjectArrayList = self.gameObject.childrens;

        // TODO: only do this when a new child is inserted
        self.camera = null;
        self.skybox = null;
        self.pointLight = null;
        for (childs.items) |*child| {
            if (child.objectType) |objectType| {
                if (std.mem.eql(u8, objectType, "camera")) {
                    self.camera = @intToPtr(*Camera, child.objectPointer);
                    self.camera.?.gameObject = child.*;
                } else if (std.mem.eql(u8, objectType, "point_light")) {
                    self.pointLight = @intToPtr(*PointLight, child.objectPointer);
                    self.pointLight.?.gameObject = child.*;
                } else if (std.mem.eql(u8, objectType, "skybox")) {
                    self.skybox = child;
                }
            }
        }

        try graphics.renderScene(self, window);
    }

    pub fn add(self: *Scene, go: GameObject) !void {
        try self.gameObject.add(go);
    }

    pub fn findChild(self: *const Scene, name: []const u8) ?*GameObject {
        return self.gameObject.findChild(name);
    }

    pub fn deinit(self: *Scene) void {
        self.gameObject.deinit();
        self.assetManager.deinit();
    }

    pub fn deinitAll(self: *Scene) void {
        self.gameObject.deinitAll();
        self.assetManager.deinit();
    }
};

pub const ComponentOptions = struct {
    /// Functions called regularly depending on the updateTarget value of the Application.
    updateFn: ?fn(allocator: *Allocator, component: *Component, gameObject: *GameObject, delta: f32) anyerror!void = null
};

// TODO: redo components
pub const Component = struct {
    options: ComponentOptions,
    data: usize,

    pub fn update(self: *Component, gameObject: *GameObject, allocator: *Allocator, delta: f32) anyerror!void {
        if (self.options.updateFn) |func| {
            try func(allocator, self, gameObject, delta);
        }
    }
};

pub fn ComponentType(comptime name: @Type(.EnumLiteral), comptime Data: @Type(.Struct), options: ComponentOptions) type {
    return struct {
        pub fn new() Component {
            var data = Data {};
            var cp = Component {
                .options = options,
                .data = @ptrToInt(&data)
            };
            return cp;
        }
    };
}

// Tests
const expect = std.testing.expect;

test "empty gameobject" {
    var alloc = std.heap.page_allocator;
    var go = GameObject.createEmpty(alloc);
    expect(go.childrens.items.len == 0);
    expect(go.objectType == null);
}

test "empty scene" {
    var alloc = std.heap.page_allocator;
    var scene = try Scene.create(alloc);
    expect(scene.gameObject.objectType != null);
    expect(std.mem.eql(u8, scene.gameObject.objectType.?, "scene"));
    scene.deinit();
}

test "default camera" {
    var alloc = std.heap.page_allocator;
    var cam = try Camera.create(alloc, undefined);
    expect(cam.fov == 70); // default FOV
    expect(cam.gameObject.objectType != null);
    expect(std.mem.eql(u8, cam.gameObject.objectType.?, "camera"));
    cam.deinit();
}

comptime {
    std.testing.refAllDecls(@This());
    std.testing.refAllDecls(GameObject);
    std.testing.refAllDecls(PointLight);
}
