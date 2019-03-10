const { src, dest, parallel, series, watch } = require("gulp");
const sass = require("gulp-sass");
const minifyCSS = require("gulp-csso");
const svgo = require("gulp-svgo");
const babelify = require("babelify")
const browserify = require("browserify");
const source = require("vinyl-source-stream");
const buffer = require("vinyl-buffer");
const browsersync = require("browser-sync").create();
const del = require("del");

function html() {
    return src("src/*.html")
        .pipe(dest("dist/"))
}

function css() {
    return src("src/sass/*.scss")
        .pipe(sass({ includePaths: ['node_modules/'] }))
        .pipe(minifyCSS())
        .pipe(dest("dist/css"))
}

function scripts() {
    return browserify({
            entries: ["src/scripts/main.js"]
        })
        .transform(babelify.configure({
            presets: ["@babel/preset-env"]
        }))
        .bundle()
        .pipe(source("main.js"))
        .pipe(buffer())
        .pipe(dest("dist/scripts"))
        .pipe(browsersync.stream());
}

function svgImages() {
    return src("src/images/*.svg")
        .pipe(svgo())
        .pipe(dest("dist/images"));
}

function rasterImages() {
    return src([
            "src/images/*.png",
            "src/images/*.jpg"
        ])
        .pipe(dest("dist/images"));
}

function run(done) {
    browsersync.init({
        server: {
            baseDir: "dist/"
        },
        port: 3000
    });
    done();
}

function reload(done) {
    browsersync.reload();
    done();
}

function clean() {
    return del(["dist/"]);
}

function watchFiles() {
    watch("src/sass/**/*.scss", series(css, reload));
    watch("src/**/*.html", series(html, reload));
    watch("src/scripts/*.js", series(scripts, reload));
    watch("src/images/*.svg", series(svgImages, reload));
    watch(["src/images/*.png", "src/images/*.jpg"], series(rasterImages, reload));
}

// complex tasks
const build = series(
    clean,
    parallel(html, css, scripts, svgImages, rasterImages)
);
const serve = series(
    build,
    parallel(watchFiles, run)
);

exports.css = css;
exports.html = html;
exports.scripts = scripts;
exports.images = svgImages;
exports.serve = serve;
exports.clean = clean;
exports.default = build;
