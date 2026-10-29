default: build

build:
	cmake -S cpp -B cpp/build -DCMAKE_BUILD_TYPE=Release
	cmake --build cpp/build -j
	cargo build --manifest-path rust/Cargo.toml --release

lint:
	cargo clippy --manifest-path rust/Cargo.toml -- -D warnings

test:
	ctest --test-dir cpp/build --output-on-failure
	cargo test --manifest-path rust/Cargo.toml

acceptance:
	./scripts/run_acceptance.sh
